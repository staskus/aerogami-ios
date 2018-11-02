//
//  FeatureInteractor.swift
//  TravelFeatureKit
//
//  Created by Povilas Staskus on 02/11/2018.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import Foundation

protocol FeatureInteractor {
    func load()
    func subscribe()
    func unsubscribe()
}
