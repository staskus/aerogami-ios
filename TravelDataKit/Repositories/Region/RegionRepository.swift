//
//  RegionRepository.swift
//  TravelDataKit
//
//  Created by Povilas Staskus on 9/26/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import Foundation
import TravelKit
import SwiftDate
import RxSwift

public class RegionRepository: TravelKit.RegionRepository {
    private let localDataStore: LocalRegionDataStore
    private let localPreferencesDataStore: LocalRegionPeferencesDataStore
    private let remoteDataStore: RemoteRegionDataStore
    private let apiCacheTimeLimit = 7.days

    init(
        localDataStore: LocalRegionDataStore,
        localPreferencesDataStore: LocalRegionPeferencesDataStore,
        remoteDataStore: RemoteRegionDataStore
        ) {
        self.localDataStore = localDataStore
        self.localPreferencesDataStore = localPreferencesDataStore
        self.remoteDataStore = remoteDataStore
    }

    public func getRegions() -> Observable<[TravelKit.Region]> {
        guard let region = localDataStore.getAll().first, isPersistedWithinTimeLimit(region) else {
            return remoteDataStore.getAll()
                .do(onNext: { regions in
                    self.localDataStore.write(regions: regions)
                })
        }

        return .just(localDataStore.getAll())
    }

    public func getSelectedRegion() -> TravelKit.Region? {
        guard let selectedRegionid = localPreferencesDataStore.getSelectedRegionId(),
            let selectedRegion = localDataStore.get(by: selectedRegionid) else { return nil }

        return selectedRegion
    }

    public func saveSelectedRegion(by id: String?) {
        localPreferencesDataStore.save(selectedRegionId: id)
    }

    private func isPersistedWithinTimeLimit(_ region: TravelKit.Region) -> Bool {
        return Date() - apiCacheTimeLimit <= region.createdAt
    }
}
