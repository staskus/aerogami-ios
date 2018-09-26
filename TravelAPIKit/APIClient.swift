//
//  APIClient.swift
//  TravelAPIKit
//
//  Created by Povilas Staskus on 9/26/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import RxSwift

public protocol APIClient {
    func get(path: String) -> Observable<Any>
}
