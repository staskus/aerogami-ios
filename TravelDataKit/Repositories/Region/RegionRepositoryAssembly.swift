import Foundation
import Swinject
import TravelKit
import TravelAPIKit

public class RegionRepositoryAssembly: Assembly {

    public init() {
    }

    public func assemble(container: Container) {
        container.register(RemoteRegionDataStore.self) { r in
            APIRegionDataStore(
                apiClient: r.resolve(APIClient.self)!,
                path: "regions"
            )
        }.inObjectScope(.container)

        container.register(LocalRegionDataStore.self) { r in
            UserDefaultsRegionDataStore()
        }.inObjectScope(.container)

        container.register(LocalRegionPeferencesDataStore.self) { r in
            UserDefaultsRegionPreferencesDataStore()
        }.inObjectScope(.container)

        container.register(TravelKit.RegionRepository.self) { r in
            TravelDataKit.RegionRepository(
                localDataStore: r.resolve(LocalRegionDataStore.self)!,
                localPreferencesDataStore: r.resolve(LocalRegionPeferencesDataStore.self)!,
                remoteDataStore: r.resolve(RemoteRegionDataStore.self)!
            )
        }.inObjectScope(.container)
    }
}
