//
//  FeedTableHeaderView.swift
//  TravelFeatureKit
//
//  Created by Povilas Staskus on 10/2/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import UIKit
import SnapKit

protocol FeedTableHeaderViewDelegate: class {
    func onRegionButtonTapped()
}

class FeedTableHeaderView: UIView {
    private let titleLabel = UILabel()
    private let regionButton = UIButton()
    weak var delegate: FeedTableHeaderViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        addSubviews(
            titleLabel.style(titleLabelStyle),
            regionButton.style(regionButtonStyle)
        )
    }

    func setupConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(30)
            make.left.equalTo(self).offset(22)
        }

        regionButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom)
            make.left.equalTo(self).offset(22)
            make.height.equalTo(22)
            make.bottom.equalTo(self).offset(-8)
            make.width.equalTo(100)
        }

        regionButton.setContentCompressionResistancePriority(.required, for: .horizontal)
    }

    func configure(with region: Feed.ViewModel.Content.Region?) {
        if let region = region {
            regionButton.setTitle(region.name, for: .normal)
        } else {
            regionButton.setTitle(R.string.localizable.feedRegionButtonTitle(), for: .normal)
        }

        layoutRegionButton()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutRegionButton()
    }

    private func titleLabelStyle(_ label: UILabel) {
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        label.text = R.string.localizable.feedTabTitle()
    }

    private func regionButtonStyle(_ button: UIButton) {
        button.layer.cornerRadius = 8
        button.setBackgroundColor(Theme.primary, forUIControlState: .normal)
        button.setBackgroundColor(Theme.primaryLight, forUIControlState: .highlighted)
        button.setImage(R.image.regionPickerIcon(), for: .normal)
        button.setImage(R.image.regionPickerIcon(), for: .highlighted)
        button.setTitle(R.string.localizable.feedRegionButtonTitle(), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.addTarget(self, action: #selector(regionButtonTapped), for: .touchUpInside)
    }

    @objc private dynamic func regionButtonTapped() {
        delegate?.onRegionButtonTapped()
    }

    private func layoutRegionButton() {
        guard let imageFrame = regionButton.imageView?.frame,
            let regionTitleLabel = regionButton.titleLabel,
            let regionTitleText = regionButton.titleLabel?.text else { return }

        regionButton.imageEdgeInsets = UIEdgeInsets(top: 4, left: 6, bottom: 3, right: regionButton.bounds.width - 6 - 15)
        regionButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: imageFrame.width - 3, bottom: 0, right: 6)
        let imageWidth = imageFrame.width
        let textWidth = (regionTitleText as NSString).size(withAttributes: [NSAttributedString.Key.font: regionTitleLabel.font]).width
        let width = textWidth + imageWidth + 26
        regionButton.snp.updateConstraints { (make) in
            make.width.equalTo(width)
        }
    }
}
