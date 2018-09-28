//
//  BaseNavigationViewController.swift
//  TravelFeatureKit
//
//  Created by Povilas Staskus on 9/28/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import UIKit

class BaseNavigationViewController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isTranslucent = false
        view.backgroundColor = .white
        navigationBar.barStyle = .black
        navigationBar.tintColor = .white
        navigationBar.barTintColor = Theme.primary
        setNavigationBarHidden(true, animated: false)
    }
}
