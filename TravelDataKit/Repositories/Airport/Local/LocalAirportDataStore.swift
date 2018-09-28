//
//  LocalAirportDataStore.swift
//  TravelDataKit
//
//  Created by Povilas Staskus on 9/28/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import Foundation
import TravelKit

public protocol LocalAirportDataStore {
    func getAirport(by code: String) -> Airport?
    func write(airport: Airport)
}
