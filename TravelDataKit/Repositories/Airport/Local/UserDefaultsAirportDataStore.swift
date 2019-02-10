//
//  UserDefaultsAirportDataStore.swift
//  TravelDataKit
//
//  Created by Povilas Staskus on 9/28/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import Foundation
import RxSwift
import TravelKit

class UserDefaultsAirportDataStore: LocalAirportDataStore {
    private let key = "airportsUserDefaultsKey"
    private let defaults = UserDefaults.standard

    func getAirport(by code: String) -> Airport? {
        guard let airportData = defaults.object(forKey: key + code) as? Data else {
            return nil
        }
        
        return try? Airport.decoder.decode(Airport.self, from: airportData)
    }

    func write(airport: Airport) {
        if let data = try? Airport.encoder.encode(airport) {
            defaults.set(data, forKey: key + airport.code)
        }
    }
}
