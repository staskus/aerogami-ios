//
//  Trip.swift
//  TravelKit
//
//  Created by Povilas Staskus on 9/27/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import Foundation

public struct Trip: Codable, Equatable {
    public var id: String = ""
    public var currency: String = ""
    public var price = 0

    public var airlines = ""
    public var flightNumber = 0

    public var destination: TripLocation!
    public var departure: TripLocation!

    public var createdAt = Date()
    public var departureAt = Date()
    public var returnAt = Date()
    public var expiresAt = Date()
    
    public init() {}
    
    public static var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .millisecondsSince1970
        return decoder
    }()
    
    public static var encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        decoder.dateDecodingStrategy = .millisecondsSince1970
        return encoder
    }()
}

public struct TripLocation: Codable, Equatable {
    public var city: String!
    public var countryCode: String!
    public var airportCode: String!
    
    public init() {}
}
