//
//  RegionMappingTests.swift
//  TravelKitTests
//
//  Created by Povilas Staskus on 10/28/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import XCTest
@testable import TravelKit

class RegionMappingTests: XCTestCase {
    func test_mapping_validJSON_shouldMap() {
        //Given there is a valid region JSON
        let json = RegionTest.ValidRegion.JSON
        
        // When we map Region
        let region = Region(JSON: json)!
        
        // Then all properties should be mapped correctly
        XCTAssertTrue((json as NSDictionary).isEqual(to: region.toJSON()))
    }
    
    func test_mapping_invalidJSON_shouldBeNil() {
        //Given there is a valid region JSON
        let json = RegionTest.InvalidRegion.JSON
        
        // When we map Region
        let region = try? Region(JSON: json)
        
        // Then it should be nil
        XCTAssertNil(region)
    }
}


