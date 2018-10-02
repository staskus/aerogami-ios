//
//  UserDefaultsRegionPreferencesDataStore.swift
//  TravelDataKit
//
//  Created by Povilas Staskus on 10/2/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import Foundation
import TravelKit

class UserDefaultsRegionPreferencesDataStore: LocalRegionPeferencesDataStore {
    private let localRegionSelectedIdKey = "selected_region_id_preference_key"

    func getSelectedRegionId() -> String? {
        return UserDefaults.standard.string(forKey: localRegionSelectedIdKey)
    }

    func save(selectedRegionId: String?) {
        UserDefaults.standard.set(selectedRegionId, forKey: localRegionSelectedIdKey)
        UserDefaults.standard.synchronize()
    }
}
