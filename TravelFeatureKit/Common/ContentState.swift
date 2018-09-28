//
//  ContentState.swift
//  TravelFeatureKit
//
//  Created by Povilas Staskus on 9/27/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import UIKit

enum ContentState<ContentType: Equatable> {
    case loading(data: ContentType?)
    case error(error: ContentStateError)
    case loaded(data: ContentType, error: ContentStateError?)

    public var data: ContentType? {
        switch self {
        case .error:
            return nil
        case .loading(let data):
            return data
        case .loaded(let data, _):
            return data
        }
    }
}

extension ContentState: Equatable {

    public static func == (lhs: ContentState, rhs: ContentState) -> Bool {
        switch (lhs, rhs) {
        case (.error(let lhsError), .error(let rhsError)):
            return lhsError == rhsError
        case (.loading(let lhsData), .loading(let rhsData)):
            return lhsData == rhsData
        case (.loaded(let lhsData, _), .loaded(let rhsData, _)):
            return lhsData == rhsData
        default:
            return false
        }
    }
}

protocol EquatableError: Error, Equatable {}

enum ContentStateError: EquatableError {
    case loading(reason: String)
}

extension FeatureViewModel {
    var hasContent: Bool { return true }
}
