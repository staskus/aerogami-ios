//
//  ApplicationLoader.swift
//  TravelApplication
//
//  Created by Povilas Staskus on 9/26/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

// swiftlint:disable force_cast
// swiftlint:disable force_try

import UIKit
import Swinject
import TravelKit
import TravelFeatureKit
import CocoaLumberjack

class ApplicationLoader {
    public let assembler: Assembler
    public var window: UIWindow?

    init() {
        self.assembler = AssemblerFactory().create()
    }

    // Start the application loading sequence
    func start(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        setupLogger()
        loadRootViewController()
        prepareForInjection()
    }

    private func loadRootViewController() {
        let rootConfigurator = assembler.resolver.resolve(MainConfigurator.self)!
        let rootViewController = rootConfigurator.createViewController()
        window = assembler.resolver.resolve(UIKit.UIWindow.self)!
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }

    private func setupLogger() {
        DDLog.add(DDASLLogger.sharedInstance)
    }

    private func prepareForInjection() {
//        #if DEBUG
//        Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/iOSInjection10.bundle")?.load()
//        #endif
    }
}
