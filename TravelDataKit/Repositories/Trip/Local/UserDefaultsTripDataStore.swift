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
    private lazy var tripBehaviorSubject: BehaviorSubject<[Trip]> = {
        return BehaviorSubject(value: self.getTrips())
    }()
    
    func getTrip(by id: String) -> Trip? {
        return getTrips()
            .filter { $0.id == id }
            .first
    }

    func getTrips() -> Observable<[Trip]> {
        return tripBehaviorSubject.asObservable()
    }

    func write(trip: Trip) {
        var trips: [Trip] = getTrips()
        trips.append(trip)
        
        save(trips: trips)
    }

    func remove(trip: Trip) {
        let trips = getTrips()
            .filter { $0.id != trip.id }
        
        save(trips: trips)
    }
}

extension UserDefaultsTripDataStore {
    private func save(trips: [Trip]) {
        guard let tripsData = try? Trip.encoder.encode(trips) else {
            return
        }
        
        defaults.set(tripsData, forKey: key)
        defaults.synchronize()
        tripBehaviorSubject.onNext(getTrips())
    }
    
    private func getTrips() -> [Trip] {
        guard let tripsData = defaults.object(forKey: key) as? Data,
            let trips = try? Trip.decoder.decode([Trip].self, from: tripsData) else {
                return []
        }
        return trips
    }
}
