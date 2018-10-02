//
//  UIView+Style.swift
//  TravelFeatureKit
//
//  Created by Povilas Staskus on 10/1/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import UIKit

extension UIAppearance {

    @discardableResult
    func style(_ block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
}
