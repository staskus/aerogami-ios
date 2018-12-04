//
//  UIViewController+TopMost.swift
//  TravelFeatureKit
//
//  Created by Povilas Staskus on 11/13/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import UIKit

extension UIViewController {
    class var topMost: UIViewController {
        var topController = UIApplication.shared.keyWindow!.rootViewController!
        while let presentedViewController = topController.presentedViewController {
            topController = presentedViewController
        }
        return topController
    }
}

extension UIView {
    class var topMost: UIView {
        if let controller = (UIViewController.topMost as? UITabBarController)?.selectedViewController {
            return controller.view
        }

        return UIViewController.topMost.view
    }
    
    class var parentOfTopMost: UIView {
        if let controller = UIViewController.topMost.presentingViewController {
            return controller.view
        }
        
        return UIView.topMost
    }
}
