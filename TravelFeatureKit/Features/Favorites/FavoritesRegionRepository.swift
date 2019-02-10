//
//  FavoritesRegionRepository.swift
//  TravelDataKit
//
//  Created by Povilas Staskus on 11/27/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import Foundation
import RxSwift
import TravelKit

class FavoritesRegionRepository: TravelKit.RegionRepository {
    private let region: Region

    init() {
        var region = Region()
        region.id = "0"
        region.name = R.string.localizable.feedRegionButtonTitle()
        self.region = region
    }

    func getRegions() -> Observable<[TravelKit.Region]> {
        return Observable.deferred { () -> Observable<[TravelKit.Region]> in
            return .just([self.region])
        }
    }

    func getSelectedRegion() -> TravelKit.Region? {
        return nil
    }

    func saveSelectedRegion(by id: String?) {
    }
}
