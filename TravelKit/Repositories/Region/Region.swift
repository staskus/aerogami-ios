//
//  Region.swift
//  TravelKit
//
//  Created by Povilas Staskus on 9/26/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import Foundation
import ObjectMapper
import ObjectMapper_Realm
import RealmSwift

public class Region: Object, ImmutableMappable {
    @objc public dynamic var id: String = ""
    @objc public dynamic var name: String = ""
    @objc public dynamic var createdAt = Date()

    public override static func primaryKey() -> String? {
        return "id"
    }

    required convenience public init(map: Map) throws {
        self.init()
        id =                try map.value("id")
        name =              try map.value("name")
    }

    public func mapping(map: Map) {
        id                <- map["id"]
        name              <- map["name"]
    }
}
