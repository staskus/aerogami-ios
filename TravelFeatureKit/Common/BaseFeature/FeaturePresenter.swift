//
//  FeaturePresenter.swift
//  TravelFeatureKit
//
//  Created by Povilas Staskus on 9/27/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import Foundation
import TravelKit
import RxSwift

enum FeatureAdapterError: Error {
    case dataInconsistency
}

extension FeatureAdapterError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .dataInconsistency:
            return "Data are inconsistent"
        }
    }
}

protocol FeatureAdapter {
    associatedtype Content: Equatable
    associatedtype ViewModel: FeatureViewModel

    func makeViewModel(viewState: ViewState<ViewModel.ContentViewModel>) -> ViewModel
    func makeContentViewModel(content: Content) throws -> ViewModel.ContentViewModel
}

class FeaturePresenter<View: FeatureViewController, Adapter: FeatureAdapter> where Adapter.ViewModel == View.ViewModel {

    typealias Content = Adapter.Content
    typealias ContentViewModel = View.ViewModel.ContentViewModel

    private var currentState: ContentState<Content>?
    private var disposeBag = DisposeBag()
    let adapter: Adapter
    weak var view: View?

    init (adapter: Adapter) {
        self.adapter = adapter
    }

    func present(_ state: ContentState<Content>) {
        guard let view = self.view else {
            Logger.feature.warning("The view in \(self) is not available")
            return
        }

        self.currentState = state
        let viewState = (try? contentViewState(for: state)) ?? .error(message: R.string.localizable.errorGenericTitle())
        let viewModel = adapter.makeViewModel(viewState: viewState)
        view.update(with: viewModel)
    }

    private func contentViewState(for state: ContentState<Content>) throws -> ViewState<ContentViewModel> {
        switch state {
        case .loading(let content):
            return try loadingViewModel(with: content)
        case .loaded(let content, let error):
            return try loadedViewModel(with: content, and: error)
        case .error(let error):
            return .error(message: error.localizedDescription)
        }
    }

    private func loadingViewModel(with content: Content?) throws -> ViewState<ContentViewModel> {
        if let content = content {

            return .loading(viewModel: try adapter.makeContentViewModel(content: content))
        }

        return .loading(viewModel: nil)
    }

    private func loadedViewModel(with content: Content,
                                 and error: ContentStateError?) throws -> ViewState<ContentViewModel> {

        return .loaded(
            viewModel: try adapter.makeContentViewModel(content: content),
            errorMessage: error?.localizedDescription
        )
    }
}
