//
//  AirportMappingTests.swift
//  TravelKitTests
//
//  Created by Povilas Staskus on 26/10/2018.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import XCTest
@testable import TravelKit

class AirportMappingTests: XCTestCase {
    func test_mapping_validJSON_shouldMap() {
        //Given there is a valid airport JSON
        let json = AirportTest.ValidAiport.JSON

        // When we map Airport
        let airport = Airport(JSON: json)!

        // Then all properties should be mapped correctly
        XCTAssertTrue((json as NSDictionary).isEqual(to: airport.toJSON()))
    }

    func test_mapping_validJSON_withoutState_shouldMap() {
        //Given there is a valid airport JSON without state
        let json = AirportTest.ValidAiportWithoutState.JSON

        // When we map Airport
        let airport = Airport(JSON: json)!

        // Then all properties should be mapped correctly
        XCTAssertTrue((json as NSDictionary).isEqual(to: airport.toJSON()))
    }

    func test_mapping_invalidJSON_shouldBeNil() {
        //Given there is a valid airport JSON
        let json = AirportTest.InvalidAiportWithoutCode.JSON

        // When we map Airport
        let airport = try? Airport(JSON: json)

        // Then it should be nil
        XCTAssertNil(airport)
    }
}
