//
//  RemoteAirportDataStore.swift
//  TravelDataKit
//
//  Created by Povilas Staskus on 9/28/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import Foundation
import RxSwift
import TravelKit

enum RemoteAirportDataStoreError: Error {
    case parseError
}

protocol RemoteAirportDataStore {
    func getAirport(by code: String) -> Observable<Airport>
}
