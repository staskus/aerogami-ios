//
//  EmptyView.swift
//  TravelFeatureKit
//
//  Created by Povilas Staskus on 9/27/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import UIKit
import SnapKit

class EmptyView: UIView {
    let label = UILabel()

    init() {
        super.init(frame: .zero)
        setupView()
    }

    private func setupView() {
        backgroundColor = .clear
        isUserInteractionEnabled = false

        addSubviews(
            label
                .style(Style.Label.main)
                .style { $0.text = R.string.localizable.emptyGenericTitle() }
        )

        label.snp.makeConstraints { make in
            make.width.equalTo(snp.width).multipliedBy(0.8)
            make.centerX.equalTo(snp.centerX)
            make.centerY.equalTo(snp.centerY)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
