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
        }
    }

    private func loadData() {
        disposeBag = DisposeBag()

        contentState = .loading(data: contentState.data)

        regionRepository.getRegions()
            .map {
                Feed.Data(
                    regions: $0,
                    selectedRegionId: nil
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

//        tripRepository.getTrips(in: nil)
//            .subscribe(
//                onNext: { data in
//                    print(data)
//                },
//                onError: { error in
//                }
//            )
//            .disposed(by: disposeBag)
        
        
        airportRepository.getAirport(by: "VNO")
            .subscribe(
                onNext: { data in
                    print(data)
            },
                onError: { error in
            }
            )
            .disposed(by: disposeBag)
    }

    func subscribe() {
        presenter.present(contentState)
    }

    func unsubscribe() {
        disposeBag = DisposeBag()
    }
}
