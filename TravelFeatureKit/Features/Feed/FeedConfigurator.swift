import UIKit
import TravelKit

public class FeedConfigurator {

    private let regionRepository: RegionRepository
    private let tripRepository: TripRepository
    private let airportRepository: AirportRepository

    public init(
        regionRepository: RegionRepository,
        tripRepository: TripRepository,
        airportRepository: AirportRepository
        ) {
        self.regionRepository = regionRepository
        self.tripRepository = tripRepository
        self.airportRepository = airportRepository
    }

    public func createViewController() -> UIViewController {
        let adapter = FeedAdapter()
        let presenter = FeedPresenter(adapter: adapter)
        let interactor = FeedInteractor(
            presenter: presenter,
            regionRepository: regionRepository,
            tripRepository: tripRepository,
            airportRepository: airportRepository
        )
        let router = FeedRouter()
        let viewController = FeedViewController(interactor: interactor, router: router)

        router.viewController = viewController
        presenter.view = viewController

        return viewController
    }
}
