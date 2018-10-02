//
//  UITableView+Dequeue.swift
//  TravelFeatureKit
//
//  Created by Povilas Staskus on 10/1/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import UIKit

extension UITableView {
    func registerReusableCell<T: UITableViewCell>(_: T.Type) where T: ReusableView {
        switch T.reuseType {
        case .classReference(let className):
            self.register(className, forCellReuseIdentifier: T.reuseIdentifier)
        case .nib(let nib):
            self.register(nib, forCellReuseIdentifier: T.reuseIdentifier)
        }
    }

    func registerReusableHeaderFooterCell<T: UITableViewHeaderFooterView>(_: T.Type) where T: ReusableView {
        switch T.reuseType {
        case .classReference(let className):
            self.register(className, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
        case .nib(let nib):
            self.register(nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
        }
    }

    func dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Did you register this cell?")
        }
        return cell
    }

    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T where T: ReusableView {
        guard let cell = self.dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("Did you register this cell?")
        }
        return cell
    }
}

protocol ReusableView: class {
    static var reuseIdentifier: String { get }
    static var reuseType: ReuseType { get }
}

public enum ReuseType {
    case nib(UINib)
    case classReference(AnyClass)
}

extension ReusableView {
    static var reuseIdentifier: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!

    }
    static var reuseType: ReuseType {
        return .classReference(self)
    }
}

protocol ConfigurableCell {
    associatedtype ViewModel
    func configure(for viewModel: ViewModel)
}
