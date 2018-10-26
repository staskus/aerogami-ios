//
//  APIClientTests.swift
//  TravelAPIKitTests
//
//  Created by Povilas Staskus on 26/10/2018.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import XCTest
import RxBlocking
import RxSwift
@testable import TravelAPIKit

// MARK: - Mocks

private class APIClientMock: APIClient {
    func get(path: String) -> Observable<Any> {
        return .just(path)
    }
}

// MARK: - TESTS

class APIClientTests: XCTestCase {
    private let apiClient = APIClientMock()
    
    func testGet() {
        let path = "https://www.testUrl.com"
        let result = try! apiClient.get(path: path).toBlocking().first() as! String
        
        XCTAssertEqual(path, result)
    }
}
