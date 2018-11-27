//
//  TripImage.swift
//  TravelKit
//
//  Created by Povilas Staskus on 11/26/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import Foundation

public struct TripImage: Equatable {
    public let tripId: String
    public let imageURL: URL

    public static var empty: TripImage {
        return TripImage(tripId: "0", imageURL: URL(fileURLWithPath: ""))
    }

    public init(tripId: String, imageURL: URL) {
        self.tripId = tripId
        self.imageURL = imageURL
    }
}
