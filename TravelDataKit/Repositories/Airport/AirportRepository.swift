//
//  AirportRepository.swift
//  TravelDataKit
//
//  Created by Povilas Staskus on 9/28/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import Foundation
import TravelKit
import SwiftDate
import RxSwift

public class AirportRepository: TravelKit.AirportRepository {
    private let localDataStore: LocalAirportDataStore
    private let remoteDataStore: RemoteAirportDataStore

    init(
        localDataStore: LocalAirportDataStore,
        remoteDataStore: RemoteAirportDataStore
        ) {
        self.localDataStore = localDataStore
        self.remoteDataStore = remoteDataStore
    }

    public func getAirport(by airportCode: String) -> Observable<Airport> {
        guard let airport = localDataStore.getAirport(by: airportCode) else {
            return remoteDataStore.getAirport(by: airportCode)
                .do(onNext: { airport in
                    self.localDataStore.write(airport: airport)
                })
        }
        return .just(airport)
    }
}
