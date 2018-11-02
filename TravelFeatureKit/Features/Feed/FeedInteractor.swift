import UIKit
import RxSwift
import TravelKit

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
        airportRepository: AirportRepository
        ) {
        self.presenter = presenter
        self.regionRepository = regionRepository
        self.tripRepository = tripRepository
        self.airportRepository = airportRepository
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
        disposeBag = DisposeBag()

        contentState = .loading(data: contentState.data)

        let selectedRegion = regionRepository.getSelectedRegion()

        Observable.combineLatest(
            self.regionRepository.getRegions(),
            self.tripRepository.getTrips(in: selectedRegion?.id)
        )
            .map { (regions, trips) -> Feed.Data in
                Feed.Data(
                    regions: regions,
                    trips: trips,
                    selectedRegionId: selectedRegion?.id
                )
            }
            .subscribe(
                onNext: { data in
                    self.contentState = .loaded(data: data, error: nil)
                },
                onError: { error in
                    self.contentState = .error(error: .loading(reason: error.localizedDescription))
                }
            )
            .disposed(by: disposeBag)
    }

    func changeRegion(id: String?) {
        contentState = .loading(data: nil)
        regionRepository.saveSelectedRegion(by: id)
        load()
    }

    func subscribe() {
        presenter.present(contentState)
    }

    func unsubscribe() {
        disposeBag = DisposeBag()
    }
}
