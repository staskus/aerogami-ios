//
//  FeedPresenterTests.swift
//  TravelFeatureKitTests
//
//  Created by Povilas Staskus on 02/11/2018.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import XCTest
@testable import TravelFeatureKit

class FeedPresenterTests: XCTestCase {
    private var adapter: FeedAdapter!

    override func setUp() {
        super.setUp()
        adapter = FeedAdapter()
    }

    func test_emptyData_valid_shouldMap() {
        // Given there is an empty data struct
        let data = Feed.Data(regions: [], trips: [], selectedRegionId: nil)

        // When we make content view model

        let viewModel = try! adapter.makeContentViewModel(content: data)

        // Then it is correctly mapped

        let expectedViewModel = Feed.ViewModel.Content(rows: [], availableRegions: [], selectedRegion: nil)

        XCTAssertEqual(viewModel, expectedViewModel)
    }
}
