//
//  APIAirportDataStore.swift
//  TravelDataKit
//
//  Created by Povilas Staskus on 9/28/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import RxSwift
import TravelKit
import TravelAPIKit

class APIAirportDataStore: RemoteAirportDataStore {
    private let apiClient: APIClient
    private let path: String

    init(apiClient: APIClient, path: String) {
        self.apiClient = apiClient
        self.path = path
    }

    func getAirport(by code: String) -> Observable<Airport> {
        let fullPath = "\(path)/\(code)"
        return apiClient.get(path: fullPath)
            .map { response in
                guard let body = ((response as? [String: Any])?["body"]) as? String,
                    let data = body.data(using: .utf8),
                    let airport = try? Airport.decoder.decode(Airport.self, from: data) else {
                    throw RemoteAirportDataStoreError.parseError
                }
                return airport
        }
    }
}
