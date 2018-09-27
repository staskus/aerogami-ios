import UIKit
import TravelKit

public class FeedConfigurator {
    
    private let regionRepository: RegionRepository

    public init(regionRepository: RegionRepository) {
        self.regionRepository = regionRepository
    }

    public func createViewController() -> UIViewController {
        let adapter = FeedAdapter()
        let presenter = FeedPresenter(adapter: adapter)
        let interactor = FeedInteractor(presenter: presenter, regionRepository: regionRepository)
        let router = FeedRouter()
        let viewController = FeedViewController(interactor: interactor, router: router)

        router.viewController = viewController
        presenter.view = viewController

        return viewController
    }
}
