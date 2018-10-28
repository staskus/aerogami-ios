//
//  Trip.swift
//  TravelKit
//
//  Created by Povilas Staskus on 9/27/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import Foundation
import ObjectMapper
import ObjectMapper_Realm
import RealmSwift

public class Trip: Object, ImmutableMappable {
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

    public override static func primaryKey() -> String? {
        return "id"
    }

    required convenience public init(map: Map) throws {
        self.init()
        id =                      try map.value("id")
        currency =                try map.value("currency")
        price =                   try map.value("price")
        airlines =                try map.value("airlines")
        flightNumber =            try map.value("flight_number")
        destination               <- map["destination"]
        departure                 <- map["departure"]
        createdAt =               try map.value("created_at", using: APIDateTransform())
        departureAt =             try map.value("departure_at", using: APIDateTransform())
        returnAt =                try map.value("return_at", using: APIDateTransform())
        expiresAt =               try map.value("expires_at", using: APIDateTransform())
    }

    public func mapping(map: Map) {
        id                      >>> map["id"]
        currency                >>> map["currency"]
        price                   >>> map["price"]
        airlines                >>> map["airlines"]
        flightNumber            >>> map["flight_number"]
        destination             >>> map["destination"]
        departure               >>> map["departure"]
        createdAt               >>> (map["created_at"], APIDateTransform())
        departureAt             >>> (map["departure_at"], APIDateTransform())
        returnAt                >>> (map["return_at"], APIDateTransform())
        expiresAt               >>> (map["expires_at"], APIDateTransform())
    }
}

public class TripLocation: Object, ImmutableMappable {
    @objc public dynamic var city: String!
    @objc public dynamic var countryCode: String!
    @objc public dynamic var airportCode: String!

    public override static func primaryKey() -> String? {
        return "airportCode"
    }

    required convenience public init(map: Map) throws {
        self.init()
        city =                     try map.value("city")
        countryCode =              try map.value("country_code")
        airportCode =              try map.value("airport_code")
    }

    public func mapping(map: Map) {
        city                     <- map["city"]
        countryCode              <- map["country_code"]
        airportCode              <- map["airport_code"]
    }
}
