import UIKit
import TravelKit

public class FeedConfigurator {

    private let regionRepository: RegionRepository
    private let tripRepository: TripRepository
    private let airportRepository: AirportRepository
    private let tripImageRepository: TripImageRepository

    weak var bookTripConfigurator: BookTripConfigurator!

    public init(
        regionRepository: RegionRepository,
        tripRepository: TripRepository,
        airportRepository: AirportRepository,
        tripImageRepository: TripImageRepository) {
        self.regionRepository = regionRepository
        self.tripRepository = tripRepository
        self.airportRepository = airportRepository
        self.tripImageRepository = tripImageRepository
    }

    public func createViewController() -> UIViewController {
        let adapter = FeedAdapter()
        let presenter = FeedPresenter(adapter: adapter)
        let interactor = FeedInteractor(
            presenter: presenter,
            regionRepository: regionRepository,
            tripRepository: tripRepository,
            airportRepository: airportRepository,
            tripImageRepository: tripImageRepository
        )
        let router = FeedRouter(bookTripConfigurator: bookTripConfigurator)
        let viewController = FeedViewController(interactor: interactor, router: router)

        router.viewController = viewController
        presenter.view = viewController

        return viewController
    }
}
