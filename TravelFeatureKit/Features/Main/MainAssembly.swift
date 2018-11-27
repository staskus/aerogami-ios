import Foundation
import Swinject
import TravelKit

public class MainAssembly: Assembly {

    public init() {
    }

    public func assemble(container: Container) {
        container.register(MainConfigurator.self) { r in
            MainConfigurator()
        }
        .initCompleted { (r, c) in
            c.feedConfigurator = r.resolve(FeedConfigurator.self)!
            c.favoritesConfigurator = r.resolve(FavoritesConfigurator.self)!
        }
        .inObjectScope(.container)
    }
}
