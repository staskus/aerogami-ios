//
//  RealmAirportDataStore.swift
//  TravelDataKit
//
//  Created by Povilas Staskus on 9/28/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import TravelKit

class RealmAirportDataStore: LocalAirportDataStore {
    private var realm: Realm

    init() {
        self.realm = try! Realm()
    }

    func getAirport(by code: String) -> Airport? {
        return self.realm.object(ofType: Airport.self, forPrimaryKey: code)
    }

    func write(airport: Airport) {
        try! self.realm.write {
            self.realm.add(airport, update: true)
        }
    }
}
