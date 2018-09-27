import Foundation
import Swinject
import TravelKit

public class FeedAssembly: Assembly {

    public init() {
    }

    public func assemble(container: Container) {
        container.register(FeedConfigurator.self) { r in
            FeedConfigurator(
                regionRepository: r.resolve(RegionRepository.self)!
            )
        }.inObjectScope(.container)
    }
}
