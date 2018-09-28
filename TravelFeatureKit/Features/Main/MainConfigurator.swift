import UIKit
import TravelKit

public class MainConfigurator {
    
    var feedConfigurator: FeedConfigurator!
    var preferencesConfigurator: PreferencesConfigurator!
    
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
        
        let preferencesViewController = preferencesConfigurator.createViewController()
        preferencesViewController.tabBarItem = UITabBarItem(
            title: R.string.localizable.preferencesTabTitle(),
            image: R.image.tabPreferencesIcon(),
            tag: 1
        )
        viewControllers.append(BaseNavigationViewController(rootViewController: preferencesViewController))
        
        let viewController = MainViewController(viewControllers: viewControllers)
        
        return viewController
    }
}
