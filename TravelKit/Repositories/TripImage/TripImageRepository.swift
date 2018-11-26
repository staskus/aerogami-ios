//
//  TripImageRepository.swift
//  TravelKit
//
//  Created by Povilas Staskus on 11/26/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import RxSwift

public protocol TripImageRepository {
    func getImageURL(for trip: Trip) -> Observable<TripImage>
    func getImageURLs(for trips: [Trip]) -> Observable<[TripImage]>
}
