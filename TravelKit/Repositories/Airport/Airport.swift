//
//  Airport.swift
//  TravelKit
//
//  Created by Povilas Staskus on 9/28/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import Foundation

public struct Airport: Codable, Equatable {
    public var code: String = ""
    public var city: String = ""
    public var countryCode: String = ""
    public var name: String = ""
    public var state: String?
    public var lon = 0.0
    public var lat = 0.0
    
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
}
