//
//  TripRepository.swift
//  TravelKit
//
//  Created by Povilas Staskus on 9/28/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import RxSwift

public protocol TripRepository {
    func getTrips(in region: String?) -> Observable<[Trip]>
}
