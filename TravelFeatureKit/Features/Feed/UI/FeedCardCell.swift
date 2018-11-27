//
//  FeedCardCell.swift
//  TravelFeatureKit
//
//  Created by Povilas Staskus on 10/1/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

struct FeedCardViewModel: Equatable {
    let direction: String
    let trip: String
    let price: String
    let dateRange: String
    let routeName: String
    let imageUrl: URL?
    let route: Feed.Route
    let isExpired: Bool
}

class FeedCardCell: UITableViewCell, ReusableView {

    private let containerView = UIView()
    private let topView = FeedCardTopView()
    private let bottomView = FeedCardBottomView()
    private let expiredView = FeedCardExpiredView()
    private let backgroundButton = UIButton()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }

    func configure(with viewModel: FeedCardViewModel) {
        topView.configure(with: viewModel)
        bottomView.configure(with: viewModel)
        expiredView.isHidden = !viewModel.isExpired
    }

    private func setupView() {
        contentView.addSubview(containerView)
        selectionStyle = .none

        containerView.addSubviews(
            topView,
            bottomView,
            expiredView.style { $0.isHidden = true },
            backgroundButton.style(backgroundButtonStyle)
        )
    }

    private func setupConstraints() {
        containerView.snp.makeConstraints { (make) in
            make.edges
                .equalTo(self.contentView)
                .inset(UIEdgeInsets(top: 0, left: 20, bottom: 30, right: 20)).priority(750)
            make.width.lessThanOrEqualTo(335).priority(751)
            make.centerX.equalTo(self.contentView).priority(751)
            make.height.equalTo(412)
        }

        topView.snp.makeConstraints { (make) in
            make.top.equalTo(self.containerView)
            make.left.equalTo(self.containerView)
            make.right.equalTo(self.containerView)
            make.height.equalTo(300)
        }

        bottomView.snp.makeConstraints { (make) in
            make.top.equalTo(self.topView.snp.bottom)
            make.left.equalTo(self.containerView)
            make.right.equalTo(self.containerView)
            make.bottom.equalTo(self.containerView)
        }

        expiredView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.containerView)
        }

//        backgroundButton.snp.makeConstraints { (make) in
//            make.edges.equalTo(self.containerView)
//        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setShadowIfNeeded()
        roundCorners()
    }

    private func setShadowIfNeeded() {
        containerView.layoutIfNeeded()
        let containerFrame = CGRect(
            x: (UIScreen.main.bounds.width - containerView.frame.width)/2,
            y: 0,
            width: containerView.bounds.width,
            height: containerView.bounds.height
        )
        let shadowPath = UIBezierPath(roundedRect: containerFrame, cornerRadius: 15).cgPath
        guard contentView.layer.shadowPath != shadowPath else { return }
        contentView.layer.cornerRadius = 15
        contentView.layer.shadowOffset = CGSize(width: 0, height: 16)
        contentView.layer.shadowOpacity = 0.3
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowPath = shadowPath
    }

    private func roundCorners() {
        containerView.layer.cornerRadius = 15
        containerView.clipsToBounds = true
        containerView.layer.masksToBounds = true
    }

    private func backgroundButtonStyle(_ button: UIButton) {
        return
        backgroundButton.addTarget(self, action: #selector(onTouchDown), for: .touchDown)
        backgroundButton.addTarget(self, action: #selector(onTouchUp), for: .touchUpInside)
        backgroundButton.addTarget(self, action: #selector(onTouchUp), for: .touchUpOutside)
        backgroundButton.addTarget(self, action: #selector(onTouchUp), for: .touchCancel)
    }

    @objc private func onTouchDown() {
        alpha = 0.7
    }

    @objc private func onTouchUp() {
        alpha = 1.0
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

private class FeedCardTopView: UIView {
    private let imageView = UIImageView()
    private let gradientImageView = UIImageView()
    private let subtitleLabel = UILabel()
    private let titleLabel = UILabel()

    init() {
        super.init(frame: .zero)
        setupView()
        setupConstraints()
    }

    func configure(with viewModel: FeedCardViewModel) {
        imageView.sd_setImage(with: viewModel.imageUrl)
        subtitleLabel.text = viewModel.direction
        titleLabel.text = viewModel.trip
    }

    private func setupView() {
        backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)

        addSubviews(
            imageView.style(imageViewStyle),
            gradientImageView.style(gradientImageViewStyle),
            subtitleLabel.style(subtitleLabelStyle),
            titleLabel.style(titleLabelStyle)
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
        title.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        title.textColor = .white
        title.numberOfLines = 2
        title.adjustsFontSizeToFitWidth = true
        title.minimumScaleFactor = 0.75
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private class FeedCardBottomView: UIView {
    private let button = UIButton()
    private let topLabel = UILabel()
    private let priceLabel = UILabel()
    private let dateLabel = UILabel()

    init() {
        super.init(frame: .zero)
        setupView()
        setupConstraints()
    }

    func configure(with viewModel: FeedCardViewModel) {
        button.setTitle("  \(viewModel.routeName)  ", for: .normal)
        topLabel.text = R.string.localizable.feedTotalPriceTitle().lowercased()
        priceLabel.text = viewModel.price
        dateLabel.text = viewModel.dateRange
    }

    private func setupView() {
        backgroundColor = .white

        addSubviews(
            button.style(Style.Button.main).style(buttonStyle),
            topLabel.style(topLabelStyle),
            priceLabel.style(priceLabelStyle),
            dateLabel.style(dateLabelStyle)
        )
    }

    private func setupConstraints() {
        let sideOffset = 20

        topLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(sideOffset)
            make.left.equalTo(self).offset(sideOffset)
        }

        priceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(topLabel.snp.lastBaseline).offset(-2)
            make.left.equalTo(self).offset(sideOffset)
        }

        dateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(priceLabel.snp.lastBaseline).offset(4)
            make.left.equalTo(self).offset(sideOffset)
        }

        button.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(-12)
            make.bottom.equalTo(self).offset(-12)
            make.height.equalTo(29)
        }

        topLabel.setContentHuggingPriority(.required, for: .vertical)
        priceLabel.setContentHuggingPriority(.required, for: .vertical)
        dateLabel.setContentHuggingPriority(.required, for: .vertical)
    }

    private func topLabelStyle(_ label: UILabel) {
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = Theme.primaryLight
    }

    private func priceLabelStyle(_ price: UILabel) {
        price.font = UIFont.systemFont(ofSize: 48, weight: .bold)
        price.textColor = Theme.primary
    }

    private func dateLabelStyle(_ date: UILabel) {
        date.font = UIFont.systemFont(ofSize: 14, weight: .light)
        date.textColor = Theme.primaryLight
    }

    private func buttonStyle(_ button: UIButton) {
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.isUserInteractionEnabled = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private class FeedCardExpiredView: UIView {
    private let backgroundView = UIView()
    private let expiredLabel = UILabel()

    init() {
        super.init(frame: .zero)
        setupView()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubviews(
            backgroundView.style(backgroundStyle),
            expiredLabel.style(expiredLabelStyle)
        )
    }

    private func setupConstraints() {
        backgroundView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }

        expiredLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.centerX.equalTo(self)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
        }
    }

    private func backgroundStyle(_ view: UIView) {
        view.backgroundColor = .white
        view.alpha = 0.7
    }

    private func expiredLabelStyle(_ label: UILabel) {
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.alpha = 0.8
        label.textColor = Theme.primaryLight
        label.font = UIFont.systemFont(ofSize: 36, weight: .heavy)
        label.text = R.string.localizable.feedExpiredTitle()
        label.textAlignment = .center
    }
}
