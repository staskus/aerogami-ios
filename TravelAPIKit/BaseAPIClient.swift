//
//  BaseAPIClient.swift
//  TravelAPIKit
//
//  Created by Povilas Staskus on 9/26/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import RxAlamofire
import RxSwift

public class BaseAPIClient: APIClient {
    private let baseUrl: String
    
    public init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    public func get(path: String) -> Observable<Any> {
        return RxAlamofire
            .requestJSON(.get, "\(baseUrl)/\(path)")
            .debug("DEBUG: [API][GET] /\(path)", trimOutput: true)
            .map { $1 }
    }
}
