//
//  FeatureViewController.swift
//  TravelFeatureKit
//
//  Created by Povilas Staskus on 9/27/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import UIKit
import SnapKit
import TravelKit

protocol FeatureViewModel {
    associatedtype ContentViewModel: FeatureContentViewModel
    var state: ViewState<ContentViewModel> { get }
}

protocol FeatureContentViewModel {
    var hasContent: Bool { get }
}

extension FeatureContentViewModel {
    var hasContent: Bool { return true }
}

enum ViewState<ViewModel> {
    case loading(viewModel: ViewModel?)
    case loaded(viewModel: ViewModel, errorMessage: String?)
    case error(message: String)

    var viewModel: ViewModel? {
        switch self {
        case .loading(let viewModel):
            return viewModel
        case .loaded(let viewModel, _):
            return viewModel
        default:
            return nil
        }
    }
}

protocol FeatureViewController: class {

    associatedtype ViewModel: FeatureViewModel

    var errorView: UIView? { get set }
    var loadingView: UIView? { get set }
    var emptyView: UIView? { get set }
    var viewModel: ViewModel? { get set }

    func update(with viewModel: ViewModel)
    func configureView()
    func setupErrorView()
    func setupLoadingView()
    func setupEmptyView()
    func setupStateViews()
    func display()
}

extension FeatureViewController {
    var viewModelState: ViewState<Self.ViewModel.ContentViewModel>? {
        return viewModel?.state
    }
}

extension FeatureViewController where Self: UIViewController {
    func update(with viewModel: ViewModel) {
        guard isViewLoaded else {
            return
        }

        self.viewModel = viewModel
        self.configureView()
    }
}

extension FeatureViewController where Self: UIViewController {
    func configureView() {
        guard let viewModelState = viewModelState else {
            Logger.feature.warning("configureView called in \(String(describing: type(of: self)))but no viewModel available")
            return
        }

        switch viewModelState {
        case .loading(let viewModel):
            UIApplication.shared.isNetworkActivityIndicatorVisible = true

            // If view model exists
            if let viewModel = viewModel {
                configureView(for: viewModel)
            } else {
                // If there is no viewModel

                if let loadingView = loadingView {

                    // Show loadingView
                    view.bringSubviewToFront(loadingView)
                    loadingView.isHidden = false
                }
                emptyView?.isHidden = true
                errorView?.isHidden = true
            }

        case .error(_):
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            emptyView?.isHidden = true
            loadingView?.isHidden = true
            if let errorView = errorView {
                view.bringSubviewToFront(errorView)
                errorView.isHidden = false
            }
        case .loaded(let viewModel, _):
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            configureView(for: viewModel)
        }

    }

    private func configureView(for viewModel: FeatureContentViewModel) {
        // If viewModel doesn't have content
        if !viewModel.hasContent {
            if let emptyView = emptyView {

                // Show Empty view
                view.bringSubviewToFront(emptyView)
                emptyView.isHidden = false
            }
        } else {
            // If viewModel has content, hide emptyView
            emptyView?.isHidden = true
            display()
        }

        errorView?.isHidden = true
        loadingView?.isHidden = true
    }
}

extension FeatureViewController where Self: UIViewController {
    func setupStateViews() {
        setupLoadingView()
        setupEmptyView()
        setupErrorView()
    }

    func setupErrorView() {
        errorView = ErrorView()
        guard let errorView = errorView else { return }
        view.addSubview(errorView)
        errorView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        errorView.isHidden = true
    }

    func setupLoadingView() {
        loadingView = LoadingView()
        guard let loadingView = loadingView else { return }
        view.addSubview(loadingView)
        loadingView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        loadingView.isHidden = true
    }

    func setupEmptyView() {
        emptyView = EmptyView()
        guard let emptyView = emptyView else { return }
        view.addSubview(emptyView)
        emptyView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        emptyView.isHidden = true
    }
}
