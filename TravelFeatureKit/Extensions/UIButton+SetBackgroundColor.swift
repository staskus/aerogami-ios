//
//  UIButton+SetBackgroundColor.swift
//  TravelFeatureKit
//
//  Created by Povilas Staskus on 10/1/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import UIKit

extension UIButton {
    private func imageWithColor(_ color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()

        context!.setFillColor(color.cgColor)
        context!.fill(rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image!
    }

    func setBackgroundColor(_ color: UIColor, forUIControlState state: UIControl.State) {
        setBackgroundImage(imageWithColor(color), for: state)
        clipsToBounds = true
    }
}
