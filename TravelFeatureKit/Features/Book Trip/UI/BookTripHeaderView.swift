//
//  BookTripHeaderView.swift
//  TravelFeatureKit
//
//  Created by Povilas Staskus on 11/13/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import UIKit
import RxCocoa

struct BookTripHeaderViewModel {
    let title: String
    let subtitle: String
    let imageUrl: URL
}

class BookTripHeaderView: UIView {
    private let imageView = UIImageView()
    private let gradientImageView = UIImageView()
    private let subtitleLabel = UILabel()
    private let titleLabel = UILabel()
    let closeButton = UIButton()

    init() {
        super.init(frame: .zero)
        setupView()
        setupConstraints()
    }

    func configure(with viewModel: BookTripHeaderViewModel) {
        imageView.sd_setImage(with: viewModel.imageUrl)
        subtitleLabel.text = viewModel.subtitle
        titleLabel.text = viewModel.title
    }

    private func setupView() {
        backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)
        clipsToBounds = true

        addSubviews(
            imageView.style(imageViewStyle),
            gradientImageView.style(gradientImageViewStyle),
            subtitleLabel.style(subtitleLabelStyle),
            titleLabel.style(titleLabelStyle),
            closeButton.style(closeButtonStyle)
        )
    }

    private func setupConstraints() {
        imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }

        gradientImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.imageView)
        }

        subtitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(24)
            make.left.equalTo(self).offset(20)
        }

        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.subtitleLabel.snp.bottom).offset(2)
            make.left.equalTo(self).offset(20)
            make.right.lessThanOrEqualTo(self).offset(-10)
        }

        closeButton.snp.makeConstraints { (make) in
            make.top.equalTo(18)
            make.right.equalTo(-18)
            make.height.equalTo(24)
            make.width.equalTo(24)

        }
    }

    private func imageViewStyle(_ imageView: UIImageView) {
        imageView.contentMode = .scaleAspectFill
    }

    private func gradientImageViewStyle(_ imageView: UIImageView) {
        imageView.contentMode = .scaleToFill
        imageView.image = R.image.feedCardGradient()
        imageView.alpha = 0.75
    }

    private func subtitleLabelStyle(_ subtitle: UILabel) {
        subtitle.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        subtitle.alpha = 0.7
        subtitle.textColor = .white
        subtitle.numberOfLines = 1
    }

    private func titleLabelStyle(_ title: UILabel) {
        title.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        title.textColor = .white
        title.numberOfLines = 2
        title.adjustsFontSizeToFitWidth = true
        title.minimumScaleFactor = 0.75
    }

    private func closeButtonStyle(_ button: UIButton) {
        button.setImage(R.image.closeIcon(), for: .normal)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
