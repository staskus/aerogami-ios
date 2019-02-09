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
            .map { try? JSONSerialization.data(withJSONObject: $0, options: []) }
            .map { response in
                guard let data = response, let trips = try? Trip.decoder.decode([Trip].self, from: data) else {
                    throw RemoteTripDataStoreError.parseError
                }
                return trips
        }
    }
}
