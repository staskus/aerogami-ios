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
        let tripJson = TripTest.ValidTrip.stringData

        // When we map Trip
        let trip = try? Trip.decoder.decode(Trip.self, from: tripJson)

        // Then it should be map without producing nil
        XCTAssertNotNil(trip)
    }

    func test_mapping_validJSON_shouldMapAllProperties() {
        //Given there is a valid trip JSON
        let json = TripTest.ValidTrip.jsonData

        // When we map Trip
        let trip = try! Trip.decoder.decode(Trip.self, from: json)

        // Then all properties should be mapped correctly
        let jsonDictionary = try! JSONSerialization.jsonObject(with: json, options: []) as! NSDictionary
        let tripDictionary = try! JSONSerialization.jsonObject(with: (try! Trip.encoder.encode(trip)), options: []) as! NSDictionary
        XCTAssertEqual(jsonDictionary, tripDictionary)
    }

    func test_mapping_invalidJSON_shouldBeNil() {
        //Given there is a valid trip JSON
        let json = TripTest.InvalidTrip.jsonData

        // When we map Trip
        let trip = try? Trip.decoder.decode(Trip.self, from: json)

        // Then it should be nil
        XCTAssertNil(trip)
    }

    func test_mapping_invalidString_shouldBeNil() {
        //Given there is a valid trip JSON
        let string = TripTest.InvalidTrip.stringData

        // When we map Trip
        let trip = try? Trip.decoder.decode(Trip.self, from: string)

        // Then it should be nil
        XCTAssertNil(trip)
    }
}
