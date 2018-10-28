//
//  TripTest.swift
//  TravelKitTests
//
//  Created by Povilas Staskus on 10/28/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import Foundation
@testable import TravelKit

struct TripTest {
    struct Data {
        static let id = "x"
        static let currency = "EUR"
        static let price = 0
        static let airlines = "LFG"
        static let flightNumber = 0
        
        static let createdAt = APIDateTransform().transformToJSON(Date())!
        static let departureAt = APIDateTransform().transformToJSON(Date())!
        static let returnAt = APIDateTransform().transformToJSON(Date())!
        static let expiresAt = APIDateTransform().transformToJSON(Date())!
        
        
        struct TripLocationDeparture {
            static let city = "Kaunas"
            static let countryCode = "LTU"
            static let airportCode = "KNO"
        }
        
        struct TripLocationDestination {
            static let city = "Vilnius"
            static let countryCode = "LTU"
            static let airportCode = "VNO"
        }
    }
    
    struct ValidTrip {
        
        static let string = "    {\r\n        \"currency\": \"EUR\",\r\n        \"created_at\": 1540475178515,\r\n        \"airlines\": \"N7\",\r\n        \"departure_at\": 1541138100000,\r\n        \"destination\": {\r\n            \"city\": \"Warsaw\",\r\n            \"country_code\": \"PL\",\r\n            \"airport_code\": \"WAW\"\r\n        },\r\n        \"flight_number\": 290,\r\n        \"departure\": {\r\n            \"city\": \"Jyvaskylan Maalaiskunta\",\r\n            \"country_code\": \"FI\",\r\n            \"airport_code\": \"JYV\"\r\n        },\r\n        \"return_at\": 1541443800000,\r\n        \"price\": 335,\r\n        \"id\": \"59830630-d85c-11e8-8dda-510233d5c648\",\r\n        \"expires_at\": 1540498394000\r\n    }"
        
        static let JSON: [String: Any] = [
            "id": TripTest.Data.id,
            "currency": TripTest.Data.currency,
            "price": TripTest.Data.price,
            "airlines": TripTest.Data.airlines,
            "flight_number": TripTest.Data.flightNumber,
            "destination": [
                "city": TripTest.Data.TripLocationDestination.city,
                "country_code": TripTest.Data.TripLocationDestination.countryCode,
                "airport_code": TripTest.Data.TripLocationDestination.airportCode
            ],
            "departure": [
                "city": TripTest.Data.TripLocationDeparture.city,
                "country_code": TripTest.Data.TripLocationDeparture.countryCode,
                "airport_code": TripTest.Data.TripLocationDeparture.airportCode
            ],
            "created_at": TripTest.Data.createdAt,
            "departure_at": TripTest.Data.departureAt,
            "return_at": TripTest.Data.returnAt,
            "expires_at": TripTest.Data.expiresAt
        ]
    }
    
    struct InvalidTrip {
               static let string = "    {\r\n        \"currency\": \"EUR\",\r\n        \"created_at\": 1540475178515,\r\n        \"airlines\": \"N7\",\r\n        \"departure_at\": 1541138100000,\r\n        \"destination\": {\r\n            \"city\": \"Warsaw\",\r\n            \"country_code\": \"PL\",\r\n            \"airport_code\": \"WAW\"\r\n        },\r\n        \"flight_number\": 290,\r\n        \"departure\": {\r\n            \"city\": \"Jyvaskylan Maalaiskunta\",\r\n            \"country_code\": \"FI\",\r\n            \"airport_code\": \"JYV\"\r\n        },\r\n        \"return_at\": 1541443800000,\r\n        \"price\": 335,\r\n        \"expires_at\": 1540498394000\r\n    }"
        
        static let JSON: [String: Any] = [
            "currency": TripTest.Data.currency,
            "price": TripTest.Data.price,
            "airlines": TripTest.Data.airlines,
            "flight_number": TripTest.Data.flightNumber,
            "destination": [
                "city": TripTest.Data.TripLocationDestination.city,
                "country_code": TripTest.Data.TripLocationDestination.countryCode,
                "airport_code": TripTest.Data.TripLocationDestination.airportCode
            ],
            "departure": [
                "city": TripTest.Data.TripLocationDeparture.city,
                "country_code": TripTest.Data.TripLocationDeparture.countryCode,
                "airport_code": TripTest.Data.TripLocationDeparture.airportCode
            ],
            "created_at": TripTest.Data.createdAt,
            "departure_at": TripTest.Data.departureAt,
            "return_at": TripTest.Data.returnAt,
            "expires_at": TripTest.Data.expiresAt
        ]
    }
}
