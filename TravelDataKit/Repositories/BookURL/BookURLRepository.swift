//
//  BookURLRepository.swift
//  TravelDataKit
//
//  Created by Povilas Staskus on 11/20/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import Foundation
import RxSwift
import TravelKit

public enum BookURLRepositoryError: Error {
    case wrongURL
}

public class BookURLRepository: TravelKit.BookURLRepository {
    private let affiliateId: String

    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()

    public init(affiliateId: String) {
        self.affiliateId = affiliateId
    }

    public func getURL(for trip: Trip) -> Observable<URL> {
        return Observable.deferred {
            guard let url = URL(string: self.urlString(for: trip)) else {
                throw BookURLRepositoryError.wrongURL
            }

            return .just(url)
        }
    }

    private func urlString(for trip: Trip) -> String {
        let from = trip.departure.airportCode!
        let to = trip.destination.airportCode!
        let currency = trip.currency
        let departureDate = dateFormatter.string(from: trip.departureAt)
        let returnDate = dateFormatter.string(from: trip.returnAt)

        return """
            http://jetradar.com/searches/new
            ?origin_iata=\(from)
            &currency=\(currency)
            &destination_iata=\(to)
            &adults=1
            &children=0
            &infants=0
            &trip_class=0
            &depart_date=\(departureDate)
            &return_date=\(returnDate)
            &marker=\(self.affiliateId)
            &with_request=true
            """
            .replacingOccurrences(of: "\n", with: "")
            .replacingOccurrences(of: " ", with: "")
    }

}
