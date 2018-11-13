//
//  APIDateTransformTests.swift
//  TravelKitTests
//
//  Created by Povilas Staskus on 10/28/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import XCTest
@testable import TravelKit

class APIDateTransformTests: XCTestCase {
    private let dateTransform = APIDateTransform()

    func test_transformFromDouble_valid_shouldReturnDate() {
        // Given there is a valid double
        let doubleValue: Double = 1540215978711

        // When we pass it
        let transformedDate = dateTransform.transformFromJSON(doubleValue)

        // Then it should return valid date
        let date = Date(timeIntervalSince1970: 1540215978.711)

        XCTAssertEqual(date, transformedDate)
    }

    func test_transformFromString_valid_shouldReturnDate() {
        // Given there is a valid double
        let stringValue: String = "1540215978711"

        // When we pass it
        let transformedDate = dateTransform.transformFromJSON(stringValue)

        // Then it should return valid date
        let date = Date(timeIntervalSince1970: 1540215978.711)

        XCTAssertEqual(date, transformedDate)
    }

    func test_transformFromJSON_invalid_shouldBeNil() {
        // Given there is a invalid value
        let invalidValue: String = "asdasdas"

        // When we pass it
        let transformedDate = dateTransform.transformFromJSON(invalidValue)

        // Then it should return nil
        XCTAssertNil(transformedDate)
    }
}
