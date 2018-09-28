import UIKit
import TravelKit

public class FeedConfigurator {
    
    private let regionRepository: RegionRepository
    private let tripRepository: TripRepository

    public init(
        regionRepository: RegionRepository,
        tripRepository: TripRepository
        ) {
        self.regionRepository = regionRepository
        self.tripRepository = tripRepository
    }

    public func createViewController() -> UIViewController {
        let adapter = FeedAdapter()
        let presenter = FeedPresenter(adapter: adapter)
        let interactor = FeedInteractor(
            presenter: presenter,
            regionRepository: regionRepository,
            tripRepository: tripRepository
        )
        let router = FeedRouter()
        let viewController = FeedViewController(interactor: interactor, router: router)

        router.viewController = viewController
        presenter.view = viewController

        return viewController
    }
}
