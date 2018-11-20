//
//  BookURLRepositoryTests.swift
//  TravelDataKitTests
//
//  Created by Povilas Staskus on 11/20/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import XCTest
import RxBlocking
@testable import TravelDataKit
@testable import TravelKit

class BookURLRepositoryTests: XCTestCase {
    private let repository = BookURLRepository(affiliateId: "key")

    func test_validTrip_getUrl_shouldReturnValidUrl() {
        // Given we have a valid trip
        let trip = TripData.validTrip

        // When we pass a trip to repository
        let url = try! repository.getURL(for: trip).toBlocking().toArray().first!

        // Then the expected string should be built
        XCTAssertEqual(url, expectedURL(for: trip))
    }

    private func expectedURL(for trip: Trip) -> URL {
        let from = trip.departure.airportCode!
        let to = trip.destination.airportCode!
        let currency = trip.currency

        let urlString = """
            http://jetradar.com/searches/new
            ?origin_iata=\(from)
            &currency=\(currency)
            &destination_iata=\(to)
            &adults=1
            &children=0
            &infants=0
            &trip_class=0
            &depart_date=1970-01-01
            &return_date=1970-01-01
            &marker=key
            &with_request=true
            """
            .replacingOccurrences(of: "\n", with: "")
            .replacingOccurrences(of: " ", with: "")

        return URL(string: urlString)!
    }
}
