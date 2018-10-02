//
//  MainViewController.swift
//  TravelFeatureKit
//
//  Created by Povilas Staskus on 9/28/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    init(viewControllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = viewControllers
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = Theme.primary
        tabBar.isTranslucent = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
