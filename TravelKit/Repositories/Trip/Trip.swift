//
//  Trip.swift
//  TravelKit
//
//  Created by Povilas Staskus on 9/27/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import Foundation
import RealmSwift

public class Trip: Object, Codable {
    @objc public dynamic var id: String = ""

    @objc public dynamic var currency: String = ""
    @objc public dynamic var price = 0

    @objc public dynamic var airlines = ""
    @objc public dynamic var flightNumber = 0

    @objc public dynamic var destination: TripLocation!
    @objc public dynamic var departure: TripLocation!

    @objc public dynamic var createdAt = Date()
    @objc public dynamic var departureAt = Date()
    @objc public dynamic var returnAt = Date()
    @objc public dynamic var expiresAt = Date()
    
    public static var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    public static var encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()

    public override static func primaryKey() -> String? {
        return "id"
    }
}

public class TripLocation: Object, Codable {
    @objc public dynamic var city: String!
    @objc public dynamic var countryCode: String!
    @objc public dynamic var airportCode: String!

    public override static func primaryKey() -> String? {
        return "airportCode"
    }
}
