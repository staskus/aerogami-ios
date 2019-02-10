//
//  UserDefaultsRegionDataStore.swift
//  TravelDataKit
//
//  Created by Povilas Staskus on 9/26/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import Foundation
import RxSwift
import TravelKit

class UserDefaultsRegionDataStore: LocalRegionDataStore {
    private let key = "regionsUserDefaultsKey"
    private let defaults = UserDefaults.standard
    
    func getAll() -> [Region] {
        guard let regionData = defaults.object(forKey: key) as? Data,
              let regions = try? Region.decoder.decode([Region].self, from: regionData) else {
                return []
        }
        
        return regions
    }

    func get(by id: String) -> Region? {
        return getAll()
            .filter { $0.id == id }
            .first
    }

    func write(regions: [Region]) {
        if let regionsData = try? Region.encoder.encode(regions) {
            defaults.set(regionsData, forKey: key)
        }
    }
}
