//
//  RegionTest.swift
//  TravelKitTests
//
//  Created by Povilas Staskus on 10/28/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import Foundation

struct RegionTest {
    struct Data {
        static let id = "blt"
        static let name = "Baltics"
    }
    
    struct ValidRegion {
        static let JSON: [String: Any] = [
            "id": RegionTest.Data.id,
            "name": RegionTest.Data.name
        ]
    }
    
    struct InvalidRegion {
        static let JSON: [String: Any] = [
            "name": RegionTest.Data.name
        ]
    }
}
