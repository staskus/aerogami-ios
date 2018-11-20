import Foundation
import Swinject
import TravelKit

public class BookTripAssembly: Assembly {

    public init() {
    }

    public func assemble(container: Container) {
        container.register(BookTripConfigurator.self) { r in
            BookTripConfigurator(
                bookURLRepository: r.resolve(TravelKit.BookURLRepository.self)!
            )
        }.inObjectScope(.container)
    }
}
