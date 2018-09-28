//
//  LoadingView.swift
//  TravelFeatureKit
//
//  Created by Povilas Staskus on 9/27/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    static let loadingAccessibilityLabel = "Default Loading View"
    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)

    init() {
        super.init(frame: .zero)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)
        activityIndicator.color = .black
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activityIndicator.isAccessibilityElement = true
        activityIndicator.accessibilityLabel = LoadingView.loadingAccessibilityLabel
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
