import UIKit
import RxSwift
import TravelKit
import RealmSwift

protocol FeedInteractable {
    func dispatch(_ action: Feed.Action)
    func changeRegion(id: String?)
}

class FeedInteractor: FeatureInteractor, FeedInteractable {
    private let presenter: FeedPresenter
    private var disposeBag = DisposeBag()

    private let regionRepository: RegionRepository
    private let tripRepository: TripRepository
    private let airportRepository: AirportRepository
    private let tripImageRepository: TripImageRepository

    private var realm: Realm {
        return try! Realm()
    }
    private var notificationToken: NotificationToken?

    private var contentState: ContentState<Feed.Data> = .loading(data: nil) {
        didSet {
            guard contentState != oldValue else { return }
            presenter.present(contentState)
        }
    }

    init(
        presenter: FeedPresenter,
        regionRepository: RegionRepository,
        tripRepository: TripRepository,
        airportRepository: AirportRepository,
        tripImageRepository: TripImageRepository
        ) {
        self.presenter = presenter
        self.regionRepository = regionRepository
        self.tripRepository = tripRepository
        self.airportRepository = airportRepository
        self.tripImageRepository = tripImageRepository
    }

    func dispatch(_ action: Feed.Action) {
        switch action {
        case .load:
            load()
        case .changeRegion(let regionId):
            changeRegion(id: regionId)
        }
    }

    func load() {
        contentState = .loading(data: nil)

        let selectedRegion = regionRepository.getSelectedRegion()

        Observable.combineLatest(
            self.regionRepository.getRegions(),
            self.tripRepository.getTrips(in: selectedRegion?.id)
            )
            .map { (regions, trips) -> Feed.Data in
                return Feed.Data(
                    regions: regions,
                    trips: trips,
                    selectedRegionId: selectedRegion?.id,
                    tripImages: []
                )
            }
            .subscribe(
                onNext: { data in
                    self.contentState = .loaded(data: data, error: nil)
                    self.loadImages(for: data.trips)
                },
                onError: { error in
                    self.contentState = .error(error: .loading(reason: error.localizedDescription))
                }
            )
            .disposed(by: disposeBag)
    }

    private func loadImages(for trips: [Trip]) {
        Observable.combineLatest(trips.map { self.tripImageRepository.getImageURL(for: $0) })
            .subscribe(
                onNext: { tripImages in
                    guard let currentData = self.contentState.data else { return }

                    let data = currentData.with(tripImages: tripImages)
                    self.contentState = .loaded(data: data, error: nil)
                }
            )
            .disposed(by: disposeBag)
    }

    func changeRegion(id: String?) {
        guard let currentData = self.contentState.data else { return }
        let data = currentData.with(trips: []).with(tripImages: [])
        self.contentState = .loaded(data: data, error: nil)

        regionRepository.saveSelectedRegion(by: id)
        load()
    }

    func subscribe() {
        presenter.present(contentState)
        subscribeForRealmNotifications()
    }

    private func subscribeForRealmNotifications() {
        notificationToken = realm.observe { [weak self] _, _ in
            self?.load()
        }
    }

    func unsubscribe() {
        disposeBag = DisposeBag()
        notificationToken?.invalidate()
    }

    deinit {
        notificationToken?.invalidate()
    }
}
