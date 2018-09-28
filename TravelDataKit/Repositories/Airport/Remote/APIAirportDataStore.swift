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
import ObjectMapper

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
                    let aiport = Mapper<Airport>().map(JSONString: body) else {
                    throw RemoteAirportDataStoreError.parseError
                }
                return aiport
        }
    }
}
