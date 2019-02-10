//
//  UserDefaultsTripDataStore.swift
//  TravelDataKit
//
//  Created by Povilas Staskus on 11/25/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import Foundation
import RxSwift
import TravelKit

class UserDefaultsTripDataStore: LocalTripDataStore {
    private let key = "tripsUserDefaultsKey"
    private let defaults = UserDefaults.standard
    
    func getTrip(by id: String) -> Trip? {
        return getTrips()
            .filter { $0.id == id }
            .first
    }

    func getTrips() -> [Trip] {
        guard let tripsData = defaults.object(forKey: key) as? Data,
              let trips = try? Trip.decoder.decode([Trip].self, from: tripsData) else {
            return []
        }
        
        return trips
    }

    func write(trip: Trip) {
        var trips = getTrips()
        trips.append(trip)
        
        if let tripsData = try? Trip.encoder.encode(trips) {
            defaults.set(tripsData, forKey: key)
        }
    }

    func remove(trip: Trip) {
        let trips = getTrips()
            .filter { $0.id != trip.id }
        
        if let tripsData = try? Trip.encoder.encode(trips) {
            defaults.set(tripsData, forKey: key)
        }
    }
}
