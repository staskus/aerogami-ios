//
//  BookURLRepository.swift
//  TravelKit
//
//  Created by Povilas Staskus on 11/20/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import Foundation
import RxSwift

public protocol BookURLRepository {
    func getURL(for trip: Trip) -> Observable<URL>
}
