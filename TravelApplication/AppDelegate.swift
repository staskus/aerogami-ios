//
//  AppDelegate.swift
//  TravelApplication
//
//  Created by Povilas Staskus on 9/26/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow? {
        get { return applicationLoader.window }
        set { applicationLoader.window = newValue }
    }
    private let applicationLoader = ApplicationLoader()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        applicationLoader.start(launchOptions: launchOptions)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
}

