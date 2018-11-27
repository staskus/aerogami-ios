//
//  FavoriteTripRepository.swift
//  TravelKit
//
//  Created by Povilas Staskus on 11/25/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import RxSwift

public protocol FavoriteTripRepository: TripRepository {
    func isFavorite(_ trip: Trip) -> Observable<Bool>
    func saveFavorite(_ trip: Trip) -> Completable
    func removeFavorite(_ trip: Trip) -> Completable
}
