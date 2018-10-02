//
//  RegionRepository.swift
//  TravelKit
//
//  Created by Povilas Staskus on 9/26/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import RxSwift

public protocol RegionRepository {
    func getRegions() -> Observable<[Region]>
    func getSelectedRegion() -> Region?
    func saveSelectedRegion(by id: String?)
}
