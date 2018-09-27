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
import ObjectMapper

class APIRegionDataStore: RemoteRegionDataStore {
    private let apiClient: APIClient
    private let path: String
    
    init(apiClient: APIClient, path: String) {
        self.apiClient = apiClient
        self.path = path
    }
    
    func getAll() -> Observable<[Region]> {
        return apiClient.get(path: path)
            .map { response in
                guard let regions = Mapper<Region>().mapArray(JSONObject: response) else {
                    throw RemoteRegionDataStoreError.parseError
                }
                return regions
        }
    }
}
