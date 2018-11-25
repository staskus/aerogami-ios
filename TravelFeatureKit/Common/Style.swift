//
//  Style.swift
//  TravelFeatureKit
//
//  Created by Povilas Staskus on 11/20/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import UIKit

struct Style {
    struct Button {
        static func main(_ button: UIButton) {
            button.setBackgroundColor(Theme.primary, forUIControlState: .normal)
            button.setBackgroundColor(Theme.primaryLight, forUIControlState: .highlighted)
            button.setTitleColor(.white, for: .normal)
            button.layer.masksToBounds = true
            button.layer.cornerRadius = 8
        }
    }
    
    struct Image {
        static func scaleAspectFit(_ image: UIImageView) {
            image.contentMode = .scaleAspectFit
        }
    }
}
