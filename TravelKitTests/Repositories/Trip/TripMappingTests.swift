//
//  TripMappingTests.swift
//  TravelKitTests
//
//  Created by Povilas Staskus on 10/28/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import XCTest
@testable import TravelKit

class TripMappingTests: XCTestCase {
    func test_mapping_validString_shouldMap() {
        //Given there is a valid trip JSON
        let string = TripTest.ValidTrip.string

        // When we map Trip
        let trip = try? Trip(JSONString: string)

        // Then it should be map without producing nil
        XCTAssertNotNil(trip)
    }

    func test_mapping_validJSON_shouldMapAllProperties() {
        //Given there is a valid trip JSON
        let json = TripTest.ValidTrip.JSON

        // When we map Trip
        let trip = Trip(JSON: json)!

        // Then all properties should be mapped correctly
        XCTAssertTrue((json as NSDictionary).isEqual(to: trip.toJSON()))
    }

    func test_mapping_invalidJSON_shouldBeNil() {
        //Given there is a valid trip JSON
        let json = TripTest.InvalidTrip.JSON

        // When we map Trip
        let trip = try? Trip(JSON: json)

        // Then it should be nil
        XCTAssertNil(trip)
    }

    func test_mapping_invalidString_shouldBeNil() {
        //Given there is a valid trip JSON
        let string = TripTest.InvalidTrip.string

        // When we map Trip
        let trip = try? Trip(JSONString: string)

        // Then it should be nil
        XCTAssertNil(trip)
    }
}
