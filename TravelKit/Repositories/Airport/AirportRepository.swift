//
//  AirportRepository.swift
//  TravelKit
//
//  Created by Povilas Staskus on 9/28/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import RxSwift

public protocol AirportRepository {
    func getAirport(by airportCode: String) -> Observable<Airport>
}
