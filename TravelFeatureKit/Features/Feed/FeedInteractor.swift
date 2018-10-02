import UIKit
import RxSwift
import TravelKit

class FeedInteractor {
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
            loadData()
        case .changeRegion(let regionId):
            changeRegion(id: regionId)
        }
    }

    private func loadData() {
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
                    trips: trips.sorted { $0.createdAt < $1.createdAt },
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

    private func changeRegion(id: String?) {
        contentState = .loading(data: nil)
        regionRepository.saveSelectedRegion(by: id)
        loadData()
    }

    func subscribe() {
        presenter.present(contentState)
    }

    func unsubscribe() {
        disposeBag = DisposeBag()
    }
}
