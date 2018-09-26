//
//  LocalRegionDataStore.swift
//  TravelDataKit
//
//  Created by Povilas Staskus on 9/26/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import Foundation
import TravelKit

public protocol LocalRegionDataStore {
    func getAll() -> [Region]
    func write(regions: [Region])
}
