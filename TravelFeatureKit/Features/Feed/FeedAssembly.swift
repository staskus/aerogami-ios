import Foundation
import Swinject
import TravelKit

public class FeedAssembly: Assembly {

    public init() {
    }

    public func assemble(container: Container) {
        container.register(FeedConfigurator.self) { _ in
            FeedConfigurator()
        }.inObjectScope(.container)
    }
}
