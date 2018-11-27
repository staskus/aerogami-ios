import UIKit
import TravelKit

public class MainConfigurator {

    var feedConfigurator: FeedConfigurator!
    var favoritesConfigurator: FavoritesConfigurator!

    public init() {
    }

    public func createViewController() -> UIViewController {

        var viewControllers: [UIViewController] = []

        let feedViewController = feedConfigurator.createViewController()
        feedViewController.tabBarItem = UITabBarItem(
            title: R.string.localizable.feedTabTitle(),
            image: R.image.tabFeedIcon(),
            tag: 0
        )
        viewControllers.append(BaseNavigationViewController(rootViewController: feedViewController))

        let favoritesViewController = favoritesConfigurator.createViewController()

        favoritesViewController.tabBarItem = UITabBarItem(
            title: R.string.localizable.favoritesTabTitle(),
            image: R.image.tabFavoritesIcon(),
            tag: 1
        )
        viewControllers.append(BaseNavigationViewController(rootViewController: favoritesViewController))

        let viewController = MainViewController(viewControllers: viewControllers)

        return viewController
    }
}
