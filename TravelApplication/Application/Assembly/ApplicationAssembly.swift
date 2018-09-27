//
//  ApplicationAssembly.swift
//  TravelApplication
//
//  Created by Povilas Staskus on 9/26/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import Foundation
import Swinject

class ApplicationAssembly: Assembly {
    func assemble(container: Container) {
        assembleApplication(container: container)
    }
    
    private func assembleApplication(container: Container) {
        container.register(UIKit.UIWindow.self) { _ in
            UIWindow(frame: UIScreen.main.bounds)
        }.inObjectScope(.container)
        
        container.register(ViewController.self) { _ in
            ViewController.init(nibName: nil, bundle: nil)
        }.inObjectScope(.graph)
    }
}
