//
//  RemoteTripDataStore.swift
//  TravelDataKit
//
//  Created by Povilas Staskus on 9/28/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import Foundation
import RxSwift
import TravelKit

enum RemoteTripDataStoreError: Error {
    case parseError
}

protocol RemoteTripDataStore {
    func getTrips(in region: String?) -> Observable<[Trip]>
}
