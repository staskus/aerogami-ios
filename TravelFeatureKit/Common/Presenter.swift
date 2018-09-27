//
//  Presenter.swift
//  TravelFeatureKit
//
//  Created by Povilas Staskus on 9/27/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import Foundation
import TravelKit

public protocol ViewAdapter {
    associatedtype State: Equatable
    associatedtype View: UpdatableView
    func viewModel(for state: State) -> View.UpdatableViewModel
}

protocol StoreSubscriber {
    associatedtype State
    func newState(state: State)
}

public class Presenter<Adapter: ViewAdapter>: StoreSubscriber {
    public typealias State = Adapter.State
    public typealias View  = Adapter.View
    
    private let adapter: Adapter
    public weak var view: View? //weak to avoid retain cycle
    
    private var previousState: State?
    
    public init(adapter: Adapter) {
        self.adapter = adapter
    }
    
    public func reset() {
        previousState = nil
    }
    
    public func newState(state: State) {
        guard state != previousState else { return }
        previousState = state
        
        Logger.app.debug("Presenter.newState")
        
        let viewModel = adapter.viewModel(for: state)
        view?.update(with: viewModel)
    }
}
