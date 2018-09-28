import Foundation
import Swinject
import TravelKit

public class PreferencesAssembly: Assembly {

    public init() {
    }

    public func assemble(container: Container) {
        container.register(PreferencesConfigurator.self) { _ in
            PreferencesConfigurator()
        }.inObjectScope(.container)
    }
}
