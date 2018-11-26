import Foundation
import Swinject
import TravelKit

public class BookTripAssembly: Assembly {

    public init() {
    }

    public func assemble(container: Container) {
        container.register(BookTripConfigurator.self) { r in
            BookTripConfigurator(
                bookURLRepository: r.resolve(TravelKit.BookURLRepository.self)!,
                favoriteTripRepository: r.resolve(TravelKit.FavoriteTripRepository.self)!,
                tripImageRepository: r.resolve(TravelKit.TripImageRepository.self)!
            )
        }.inObjectScope(.container)
    }
}
