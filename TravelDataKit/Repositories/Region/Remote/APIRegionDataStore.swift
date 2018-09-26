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

public class APIRegionDataStore: RemoteRegionDataStore {
    private let apiClient: APIClient
    private let path: String
    
    public init(apiClient: APIClient, path: String) {
        self.apiClient = apiClient
        self.path = path
    }
    
    public func getAll() -> Observable<[Region]> {
        return apiClient.get(path: path)
            .map { response in
                guard let regions = Mapper<Region>().mapArray(JSONObject: response) else {
                    throw RemoteRegionDataStoreError.parseError
                }
                return regions
        }
    }
}
