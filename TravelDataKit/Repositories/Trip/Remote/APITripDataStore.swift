//
//  APITripDataStore.swift
//  TravelDataKit
//
//  Created by Povilas Staskus on 9/28/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import RxSwift
import TravelKit
import TravelAPIKit
import ObjectMapper

class APITripDataStore: RemoteTripDataStore {
    private let apiClient: APIClient
    private let path: String

    init(apiClient: APIClient, path: String) {
        self.apiClient = apiClient
        self.path = path
    }

    func getTrips(in region: String?) -> Observable<[Trip]> {
        var fullPath = path
        if let region = region {
            fullPath = "\(path)/\(region)"
        }
        return apiClient.get(path: fullPath)
            .map { response in
                guard let trips = Mapper<Trip>().mapArray(JSONObject: response) else {
                    throw RemoteTripDataStoreError.parseError
                }
                return trips
        }
    }
}
