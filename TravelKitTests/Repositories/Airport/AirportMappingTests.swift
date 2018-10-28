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
    func testSingleObjectMapping() {
        //Given there is a valid airport JSON
        let json = AirportTest.ValidAiport.JSON

        // When we map Airport
        let airport = Airport(JSON: json)!

        // Then all properties should be mapped correctly
        XCTAssertTrue((json as NSDictionary).isEqual(to: airport.toJSON()))
    }
}
