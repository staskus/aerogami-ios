//
//  Airport.swift
//  TravelKit
//
//  Created by Povilas Staskus on 9/28/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import Foundation
import ObjectMapper
import ObjectMapper_Realm
import RealmSwift

public class Airport: Object, Mappable {
    @objc public dynamic var code: String = ""
    @objc public dynamic var city: String = ""
    @objc public dynamic var countryCode: String = ""
    @objc public dynamic var name: String = ""
    @objc public dynamic var state: String = ""
    @objc public dynamic var lon = 0.0
    @objc public dynamic var lat = 0.0
    
    public override static func primaryKey() -> String? {
        return "code"
    }
    
    required convenience public init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        code                <- map["code"]
        city                <- map["city"]
        countryCode         <- map["country"]
        name                <- map["name"]
        state               <- map["state"]
        lon                 <- map["lon"]
        lat                 <- map["lat"]
        
    }
}
