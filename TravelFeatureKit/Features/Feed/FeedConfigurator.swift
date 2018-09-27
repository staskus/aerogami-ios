import UIKit
import TravelKit

public class FeedConfigurator {

    public init() {
    }

    public func createViewController() -> UIViewController {
        let adapter = FeedAdapter()
        let presenter = FeedPresenter(adapter: adapter)
        let interactor = FeedInteractor(presenter: presenter)
        let router = FeedRouter()
        let viewController = FeedViewController(interactor: interactor, router: router)

        router.viewController = viewController
        presenter.view = viewController

        return viewController
    }
}
