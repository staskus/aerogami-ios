//
//  BookTripButtonsView.swift
//  TravelFeatureKit
//
//  Created by Povilas Staskus on 11/25/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

struct BookTripButtonViewModel {
    let title: String
    let imageName: String
    let action: BookTrip.Action?
    let route: BookTrip.Route?

    init(title: String, imageName: String, action: BookTrip.Action? = nil, route: BookTrip.Route? = nil) {
        self.title = title
        self.imageName = imageName
        self.action = action
        self.route = route
    }
}

protocol BookTripButtonsViewDelegate: class {
    func onButtonTapped(_ viewModel: BookTripButtonViewModel)
}

class BookTripButtonsView: UIView {
    private let stackView = UIStackView()
    private let disposeBag = DisposeBag()
    weak var delegate: BookTripButtonsViewDelegate?

    init() {
        super.init(frame: .zero)
        render()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func render() {
        addSubviews(
            stackView.style(stackViewStyle)
        )

        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top)
            make.centerY.equalTo(self.snp.centerY)
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(self.snp.bottom)
        }
    }

    func configure(with buttons: [BookTripButtonViewModel]) {
        stackView.arrangedSubviews.forEach {
            stackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }

        buttons.forEach { viewModel in
            let button = createButton(viewModel)
            stackView.addArrangedSubview(button)
        }
    }

    private func createButton(_ viewModel: BookTripButtonViewModel) -> BookTripButton {
        let button = BookTripButton()

        button.titleLabel.text = viewModel.title
        let image = UIImage(named: viewModel.imageName, in: Bundle(for: BookTripButtonsView.self), compatibleWith: nil)
        button.imageView.image = image

        button.tap.asDriver()
            .drive(onNext: { [weak self] in
                self?.delegate?.onButtonTapped(viewModel)
            })
            .disposed(by: disposeBag)

        return button
    }
}

// MARK: - Style

extension BookTripButtonsView {
    private func stackViewStyle(_ stackView: UIStackView) {
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 40
    }
}

private class BookTripButton: UIView {
    let imageView = UIImageView()
    let titleLabel = UILabel()
    private let backgroundButton = UIButton()

    var tap: ControlEvent<Void> {
        return backgroundButton.rx.tap
    }

    init() {
        super.init(frame: .zero)
        render()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func render() {
        layer.cornerRadius = 8
        backgroundColor = Theme.backgroundColor

        addSubviews(
            imageView.style(Style.Image.scaleAspectFit),
            titleLabel.style(titleStyle),
            backgroundButton
        )

        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(7)
            make.width.equalTo(23)
            make.height.equalTo(23)
            make.centerX.equalTo(self.snp.centerX)
        }

        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(4)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
        }

        backgroundButton.snp.makeConstraints { (make) in
            make.edges.equalTo(self.snp.edges)
        }

        snp.makeConstraints { (make) in
            make.width.equalTo(78)
            make.height.equalTo(52)
        }

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

    private func titleStyle(_ title: UILabel) {
        title.font = UIFont.systemFont(ofSize: 11)
        title.textAlignment = .center
        title.textColor = Theme.primary
    }
}
