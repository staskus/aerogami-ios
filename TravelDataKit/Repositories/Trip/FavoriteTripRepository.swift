//
//  FavoriteTripRepository.swift
//  TravelDataKit
//
//  Created by Povilas Staskus on 11/25/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import Foundation
import TravelKit
import RxSwift

public class FavoriteTripRepository: TravelKit.FavoriteTripRepository {
    private let localDataStore: LocalTripDataStore

    init(
        localDataStore: LocalTripDataStore
        ) {
        self.localDataStore = localDataStore
    }

    public func getFavoriteTrips() -> Observable<[Trip]> {
        return Observable.deferred { () -> Observable<[Trip]> in
            return .just(self.localDataStore.getTrips())
        }
    }

    public func isFavorite(_ trip: Trip) -> Observable<Bool> {
        return Observable.deferred { () -> Observable<Bool> in
            return .just(self.localDataStore.getTrip(by: trip.id) != nil)
        }
    }

    public func saveFavorite(_ trip: Trip) -> Completable {
        return Completable.create { completable in

            self.localDataStore.write(trip: trip)
            completable(.completed)

            return Disposables.create {}
        }
    }

    public func removeFavorite(_ trip: Trip) -> Completable {
        return Completable.create { completable in

            self.localDataStore.remove(trip: trip)
            completable(.completed)

            return Disposables.create {}
        }
    }
}
