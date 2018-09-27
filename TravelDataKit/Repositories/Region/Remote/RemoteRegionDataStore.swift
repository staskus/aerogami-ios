//
//  RemoteRegionDataStore.swift
//  TravelDataKit
//
//  Created by Povilas Staskus on 9/26/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import Foundation
import RxSwift
import TravelKit

enum RemoteRegionDataStoreError: Error {
    case parseError
}

protocol RemoteRegionDataStore {
    func getAll() -> Observable<[Region]>
}
