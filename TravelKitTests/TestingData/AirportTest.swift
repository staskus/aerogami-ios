//
//  AirportTest.swift
//  TravelKitTests
//
//  Created by Povilas Staskus on 26/10/2018.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import Foundation

struct AirportTest {
    struct ValidAiport {
        static let code = ""
        static let city = ""
        static let country = ""
        static let name = ""
        static let state = ""
        static let lon = 45.5
        static let lat = 56.65
        
        static let JSON: [String: Any] = [
            "code": AirportTest.ValidAiport.code,
            "city": AirportTest.ValidAiport.city,
            "country": AirportTest.ValidAiport.country,
            "name": AirportTest.ValidAiport.name,
            "state": AirportTest.ValidAiport.state,
            "lon": AirportTest.ValidAiport.lon,
            "lat": AirportTest.ValidAiport.lat
        ]
    }
}
