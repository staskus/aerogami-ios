//
//  BookTripTableHeaderView.swift
//  TravelFeatureKit
//
//  Created by Povilas Staskus on 11/25/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import UIKit
import SnapKit

class BookTripTableHeaderView: UITableViewHeaderFooterView, ReusableView {
    private let titleLabel = UILabel()
    private let lineView = UIView()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.render()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with title: String) {
        titleLabel.text = title
    }

    private func render() {
        backgroundView = UIView()
        backgroundView?.backgroundColor = .white

        contentView.addSubviews(
            lineView.style(lineViewStyle),
            titleLabel.style(titleStyle)
        )

        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.bottom.equalTo(self.lineView.snp.top).offset(-2)
        }

        lineView.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right).offset(-10)
            make.bottom.equalTo(self.contentView.snp.bottom)
        }

        contentView.snp.makeConstraints { (make) in
            make.height.equalTo(22)
        }
    }

    private func lineViewStyle(_ line: UIView) {
        line.backgroundColor = Theme.backgroundColor
    }

    private func titleStyle(_ title: UILabel) {
        title.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        title.textColor = UIColor.darkGray
    }
}
