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

public class RealmRegionDataStore: LocalRegionDataStore {
    private var realm: Realm
    
    public init() {
        self.realm = try! Realm()
    }
    
    public func getAll() -> [Region] {
        return Array(self.realm.objects(Region.self))
    }
    
    public func write(regions: [Region]) {
        try! self.realm.write {
            self.realm.add(regions, update: true)
        }
    }
}
