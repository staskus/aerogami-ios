//
//  UIView+CornerRadius.swift
//  TravelFeatureKit
//
//  Created by Povilas Staskus on 11/13/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import UIKit

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        layer.cornerRadius = radius

        var maskCorners = CACornerMask.ArrayLiteralElement()

        if corners.contains(.bottomLeft) {
            maskCorners.insert(.layerMinXMaxYCorner)
        }

        if corners.contains(.bottomRight) {
            maskCorners.insert(.layerMaxXMaxYCorner)
        }

        if corners.contains(.topLeft) {
            maskCorners.insert(.layerMinXMinYCorner)
        }

        if corners.contains(.topRight) {
            maskCorners.insert(.layerMaxXMinYCorner)
        }

        layer.maskedCorners = maskCorners
    }
}
