import Foundation
import Swinject
import TravelKit
import TravelAPIKit

public class TripRepositoryAssembly: Assembly {

    public init() {
    }

    public func assemble(container: Container) {
        container.register(RemoteTripDataStore.self) { r in
            APITripDataStore(
                apiClient: r.resolve(APIClient.self)!,
                path: "trips"
            )
        }.inObjectScope(.container)

        container.register(TravelKit.TripRepository.self) { r in
            TravelDataKit.TripRepository(
                remoteDataStore: r.resolve(RemoteTripDataStore.self)!
            )
        }.inObjectScope(.container)
    }
}
