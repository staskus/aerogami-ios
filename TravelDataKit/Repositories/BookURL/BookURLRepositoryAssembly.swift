import Foundation
import Swinject
import TravelKit
import TravelAPIKit

public class BookURLRepositoryAssembly: Assembly {
    private let affiliateId: String

    public init(affiliateId: String) {
        self.affiliateId = affiliateId
    }

    public func assemble(container: Container) {
        container.register(TravelKit.BookURLRepository.self) { r in
            TravelDataKit.BookURLRepository(affiliateId: self.affiliateId)
        }.inObjectScope(.container)
    }
}
