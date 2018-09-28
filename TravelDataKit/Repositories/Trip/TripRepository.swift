//
//  TripRepository.swift
//  TravelDataKit
//
//  Created by Povilas Staskus on 9/28/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import Foundation
import TravelKit
import SwiftDate
import RxSwift

public class TripRepository: TravelKit.TripRepository {
    private let remoteDataStore: RemoteTripDataStore

    init(
        remoteDataStore: RemoteTripDataStore
        ) {
        self.remoteDataStore = remoteDataStore
    }

    public func getTrips(in region: String?) -> Observable<[Trip]> {
        return remoteDataStore.getTrips(in: region)
    }
}
