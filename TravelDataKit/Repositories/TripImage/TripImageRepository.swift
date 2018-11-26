//
//  TripImageRepository.swift
//  TravelDataKit
//
//  Created by Povilas Staskus on 11/26/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import Foundation
import TravelKit
import TravelAPIKit
import RxSwift
import RxAlamofire

public enum TripImageRepositoryError: Error {
    case couldNotBuildURL
}

public class TripImageRepository: TravelKit.TripImageRepository {
    private let apiClient: APIClient
    private let defaults = UserDefaults.standard
    private let imageKey = "picsum_image_key"
    private var memoryIds: [Int] = []
    
    public init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    public func getImageURL(for trip: Trip) -> Observable<TripImage> {
        return getAllImageIds()
            .map { ids in
                let imageIndex = trip.flightNumber % ids.count
                let imageId = ids[imageIndex]
                
                guard let url = URL(string: "https://picsum.photos/1000/1000/?image=\(imageId)") else {
                    throw TripImageRepositoryError.couldNotBuildURL
                }
                
                return TripImage(tripId: trip.id, imageURL: url)
            }
    }
    
    public func getImageURLs(for trips: [Trip]) -> Observable<[TripImage]> {
        return getAllImageIds()
            .map { ids in
                var tripImages: [TripImage] = []
                
                try trips.forEach { trip in
                    let imageIndex = trip.flightNumber % ids.count
                    let imageId = ids[imageIndex]
                    
                    guard let url = URL(string: "https://picsum.photos/1000/1000/?image=\(imageId)") else {
                        throw TripImageRepositoryError.couldNotBuildURL
                    }
                    tripImages.append(TripImage(tripId: trip.id, imageURL: url))
                }
                
                return tripImages
            }
    }
    
    private func getAllImageIds() -> Observable<[Int]> {
        if !memoryIds.isEmpty {
            return .just(memoryIds)
        } else if let defaultsIds = defaults.array(forKey: imageKey) as? [Int] {
            memoryIds = defaultsIds
            return .just(defaultsIds)
        } else {
            return RxAlamofire
                .requestJSON(.get, "https://picsum.photos/list")
                .map { $1 }
                .map { images in
                    guard let imagesJSON = images as? [[String: Any]] else {
                        throw TripImageRepositoryError.couldNotBuildURL
                    }
                    
                    guard let ids = (imagesJSON.compactMap { $0["id"] }) as? [Int] else {
                        throw TripImageRepositoryError.couldNotBuildURL
                    }
                    
                    self.memoryIds = ids
                    self.defaults.setValue(ids, forKey: self.imageKey)
                    self.defaults.synchronize()
                    
                    return ids
            }
        }
    }
}
