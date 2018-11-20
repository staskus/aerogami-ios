//
//  TripData.swift
//  TravelDataKitTests
//
//  Created by Povilas Staskus on 11/20/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

@testable import TravelKit

struct TripData {
    static var validTrip: Trip {
        let trip = Trip()
        trip.id = "x"
        trip.currency = "EUR"
        trip.price = 50
        trip.airlines = "AIR"
        trip.flightNumber = 500
        trip.destination = TripLocation()
        trip.destination.airportCode = "VNO"
        trip.destination.city = "VLN"
        trip.destination.countryCode = "LTU"
        trip.destination.city = "Vilnius"

        trip.departure = TripLocation()
        trip.departure.airportCode = "KNO"
        trip.departure.city = "KNO"
        trip.departure.countryCode = "LTU"
        trip.departure.city = "Kaunas"

        trip.departureAt = Date(timeIntervalSince1970: 0)
        trip.returnAt = Date(timeIntervalSince1970: 0)
        return trip
    }
}
