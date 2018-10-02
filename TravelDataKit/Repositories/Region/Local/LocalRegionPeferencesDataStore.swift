//
//  LocalRegionPeferencesDataStore.swift
//  TravelDataKit
//
//  Created by Povilas Staskus on 10/2/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import Foundation
import TravelKit

public protocol LocalRegionPeferencesDataStore {
    func getSelectedRegionId() -> String?
    func save(selectedRegionId: String?)
}
