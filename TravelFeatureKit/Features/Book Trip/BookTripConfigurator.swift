import UIKit
import TravelKit

public class BookTripConfigurator {

    public init() {
    }

    public func createViewController() -> UIViewController {
        let adapter = BookTripAdapter()
        let presenter = BookTripPresenter(adapter: adapter)
        let interactor = BookTripInteractor(presenter: presenter)
        let router = BookTripRouter()
        let viewController = BookTripViewController(interactor: interactor, router: router)

        router.viewController = viewController
        presenter.view = viewController

        return viewController
    }
}
