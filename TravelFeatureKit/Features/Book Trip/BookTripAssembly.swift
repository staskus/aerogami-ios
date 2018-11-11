import Foundation
import Swinject
import TravelKit

public class BookTripAssembly: Assembly {

    public init() {
    }

    public func assemble(container: Container) {
        container.register(BookTripConfigurator.self) { _ in
            BookTripConfigurator()
        }.inObjectScope(.container)
    }
}
