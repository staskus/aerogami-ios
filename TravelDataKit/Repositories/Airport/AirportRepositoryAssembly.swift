import Foundation
import Swinject
import TravelKit
import TravelAPIKit

public class AirportRepositoryAssembly: Assembly {

    public init() {
    }

    public func assemble(container: Container) {
        container.register(RemoteAirportDataStore.self) { r in
            APIAirportDataStore(
                apiClient: r.resolve(APIClient.self)!,
                path: "airports"
            )
        }.inObjectScope(.container)

        container.register(LocalAirportDataStore.self) { r in
            RealmAirportDataStore()
        }.inObjectScope(.container)

        container.register(TravelKit.AirportRepository.self) { r in
            TravelDataKit.AirportRepository(
                localDataStore: r.resolve(LocalAirportDataStore.self)!,
                remoteDataStore: r.resolve(RemoteAirportDataStore.self)!
            )
        }.inObjectScope(.container)
    }
}
