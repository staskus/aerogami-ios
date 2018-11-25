//
//  RealmTripDataStore.swift
//  TravelDataKit
//
//  Created by Povilas Staskus on 11/25/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import TravelKit

class RealmTripDataStore: LocalTripDataStore {
    private var realm: Realm

    init() {
        self.realm = try! Realm()
    }

    func getTrip(by id: String) -> Trip? {
        return self.realm.object(ofType: Trip.self, forPrimaryKey: id)
    }

    func getTrips() -> [Trip] {
        return Array(self.realm.objects(Trip.self))
    }

    func write(trip: Trip) {
        let realmTrip = Trip(value: trip)
        try! self.realm.write {
            self.realm.add(realmTrip, update: true)
        }
    }

    func remove(trip: Trip) {
        guard let trip = getTrip(by: trip.id) else { return }
        try! self.realm.write {
            self.realm.delete(trip)
        }
    }
}
