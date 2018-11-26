import Foundation
import Swinject
import TravelKit

public class FeedAssembly: Assembly {

    public init() {
    }

    public func assemble(container: Container) {
        container.register(FeedConfigurator.self) { r in
            FeedConfigurator(
                regionRepository: r.resolve(RegionRepository.self)!,
                tripRepository: r.resolve(TripRepository.self)!,
                airportRepository: r.resolve(AirportRepository.self)!,
                tripImageRepository: r.resolve(TripImageRepository.self)!
            )
            }
            .initCompleted { (resolver, feedConfigurator) in
                feedConfigurator.bookTripConfigurator = resolver.resolve(BookTripConfigurator.self)!
            }
            .inObjectScope(.container)
    }
}
