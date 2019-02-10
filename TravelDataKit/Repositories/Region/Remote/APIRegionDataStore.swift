//
//  APIRegionDataStore.swift
//  TravelDataKit
//
//  Created by Povilas Staskus on 9/26/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import RxSwift
import TravelKit
import TravelAPIKit

class APIRegionDataStore: RemoteRegionDataStore {
    private let apiClient: APIClient
    private let path: String

    init(apiClient: APIClient, path: String) {
        self.apiClient = apiClient
        self.path = path
    }

    func getAll() -> Observable<[Region]> {
        return apiClient.get(path: path)
            .map { try? JSONSerialization.data(withJSONObject: $0, options: []) }
            .map { response in
                guard let data = response, let regions = try? Region.decoder.decode([Region].self, from: data) else {
                    throw RemoteRegionDataStoreError.parseError
                }
                return regions
        }
    }
}
