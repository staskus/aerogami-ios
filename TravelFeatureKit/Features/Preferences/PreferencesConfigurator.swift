import UIKit
import TravelKit

public class PreferencesConfigurator {

    public init() {
    }

    public func createViewController() -> UIViewController {
        let adapter = PreferencesAdapter()
        let presenter = PreferencesPresenter(adapter: adapter)
        let interactor = PreferencesInteractor(presenter: presenter)
        let router = PreferencesRouter()
        let viewController = PreferencesViewController(interactor: interactor, router: router)

        router.viewController = viewController
        presenter.view = viewController

        return viewController
    }
}
