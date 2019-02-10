//
//  MockAPIClient.swift
//  TravelApplication
//
//  Created by Povilas Staskus on 2/10/19.
//  Copyright © 2019 Povilas Staskus. All rights reserved.
//

import TravelAPIKit
import RxSwift

public class MockAPIClient: APIClient {
    public func get(path: String) -> Observable<Any> {
        guard let path = url(for: path),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path).absoluteURL),
              let json = try? JSONSerialization.jsonObject(with: data, options: []) else {
            return .just(())
        }
        
        return .just(json)
    }
    
    private func url(for path: String) -> String? {
        if path.contains("trips") {
            return Bundle.main.path(forResource: "TripMock", ofType: "json")
        } else if path.contains("regions") {
            return Bundle.main.path(forResource: "RegionMock", ofType: "json")
        } else if path.contains("airports") {
            return Bundle.main.path(forResource: "AirportMock", ofType: "json")
        }
        
        return nil
    }
}
