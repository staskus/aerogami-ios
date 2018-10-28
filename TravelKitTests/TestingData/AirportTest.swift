//
//  AirportTest.swift
//  TravelKitTests
//
//  Created by Povilas Staskus on 26/10/2018.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import Foundation

struct AirportTest {
    struct Data {
        static let code = "VNO"
        static let city = "Vilnius"
        static let country = "Lithuania"
        static let name = "Vilnius Airport"
        static let state = "VNO"
        static let lon = 45.5
        static let lat = 56.65
    }
    
    struct ValidAiport {
        static let JSON: [String: Any] = [
            "code": AirportTest.Data.code,
            "city": AirportTest.Data.city,
            "country": AirportTest.Data.country,
            "name": AirportTest.Data.name,
            "state": AirportTest.Data.state,
            "lon": AirportTest.Data.lon,
            "lat": AirportTest.Data.lat
        ]
    }
    
    struct ValidAiportWithoutState {
        static let JSON: [String: Any] = [
            "code": AirportTest.Data.code,
            "city": AirportTest.Data.city,
            "country": AirportTest.Data.country,
            "name": AirportTest.Data.name,
            "lon": AirportTest.Data.lon,
            "lat": AirportTest.Data.lat
        ]
    }
    
    struct InvalidAiportWithoutCode {
        static let JSON: [String: Any] = [
            "city": AirportTest.Data.city,
            "country": AirportTest.Data.country,
            "name": AirportTest.Data.name,
            "state": AirportTest.Data.state,
            "lon": AirportTest.Data.lon,
            "lat": AirportTest.Data.lat
        ]
    }
}
