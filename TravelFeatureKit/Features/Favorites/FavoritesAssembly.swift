import Foundation
import Swinject
import TravelKit

public class FavoritesAssembly: Assembly {

    public init() {
    }

    public func assemble(container: Container) {
        container.register(FavoritesConfigurator.self) { r in
            FavoritesConfigurator(
                regionRepository: r.resolve(FavoritesRegionRepository.self)!,
                tripRepository: r.resolve(FavoriteTripRepository.self)!,
                airportRepository: r.resolve(AirportRepository.self)!,
                tripImageRepository: r.resolve(TripImageRepository.self)!
                )
            }
            .initCompleted { (resolver, feedConfigurator) in
                feedConfigurator.bookTripConfigurator = resolver.resolve(BookTripConfigurator.self)!
            }
            .inObjectScope(.container)

        container.register(FavoritesRegionRepository.self) { r in
            FavoritesRegionRepository()
            }
            .inObjectScope(.container)
    }
}
