//
//  View.swift
//  TravelFeatureKit
//
//  Created by Povilas Staskus on 9/27/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import Foundation
import TravelKit

public protocol UpdatableView: class {
    associatedtype UpdatableViewModel
    func update(with viewModel: UpdatableViewModel)
}

public protocol ConfigurableView: UpdatableView {
    
    var viewModel: UpdatableViewModel? {get set}
    func configureView()
}

public extension ConfigurableView where Self: UIViewController {
    public func update(with viewModel: UpdatableViewModel) {
        Logger.app.debug("ViewController.update(with:)")
        self.viewModel = viewModel
        guard isViewLoaded else { return }
        configureView()
    }
}
