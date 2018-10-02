//
//  RealmRegionDataStore.swift
//  TravelDataKit
//
//  Created by Povilas Staskus on 9/26/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import TravelKit

class RealmRegionDataStore: LocalRegionDataStore {
    private var realm: Realm

    init() {
        self.realm = try! Realm()
    }

    func getAll() -> [Region] {
        return Array(self.realm.objects(Region.self))
    }

    func get(by id: String) -> Region? {
        return self.realm.object(ofType: Region.self, forPrimaryKey: id)
    }

    func write(regions: [Region]) {
        try! self.realm.write {
            self.realm.add(regions, update: true)
        }
    }
}
