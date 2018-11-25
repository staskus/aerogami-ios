//
//  BookTripCell.swift
//  TravelFeatureKit
//
//  Created by Povilas Staskus on 11/21/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import UIKit
import SnapKit

struct BookTripCellViewModel: Equatable {
    let title: String
    let details: String
}

class BookTripCell: UITableViewCell, ReusableView {

    private let titleLabel = UILabel()
    private let detailsContainer = UIView()
    private let detailsLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }

    func configure(with viewModel: BookTripCellViewModel) {
        titleLabel.text = viewModel.title
        detailsLabel.text = viewModel.details
    }

    private func setupView() {
        addSubviews(
            titleLabel.style(titleStyle),
            detailsContainer.style(detailsContainerStyle).addSubviews(
                detailsLabel.style(detailsStyle)
            )
        )
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(self)
            make.right.lessThanOrEqualTo(self.detailsContainer.snp.left)
        }

        detailsContainer.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(5)
            make.bottom.equalTo(self).offset(-5)
            make.right.equalTo(self)
        }

        detailsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(detailsContainer.snp.top).offset(5)
            make.right.equalTo(detailsContainer.snp.right).offset(-10)
            make.left.equalTo(detailsContainer.snp.left).offset(10)
            make.bottom.equalTo(detailsContainer.snp.bottom).offset(-5)
        }

        selectionStyle = .none
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: - Styling

extension BookTripCell {
    private func titleStyle(_ label: UILabel) {
        label.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
        label.textAlignment = .left
    }

    private func detailsStyle(_ label: UILabel) {
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textAlignment = .center
    }

    private func detailsContainerStyle(_ view: UIView) {
        view.backgroundColor = Theme.backgroundColor
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
    }
}
