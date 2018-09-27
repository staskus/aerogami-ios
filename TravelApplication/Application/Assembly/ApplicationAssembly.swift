//
//  ApplicationAssembly.swift
//  TravelApplication
//
//  Created by Povilas Staskus on 9/26/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import Foundation
import Swinject
import TravelAPIKit

class ApplicationAssembly: Assembly {
    func assemble(container: Container) {
        assembleApplication(container: container)
    }
    
    private func assembleApplication(container: Container) {
        container.register(UIKit.UIWindow.self) { _ in
            UIWindow(frame: UIScreen.main.bounds)
        }.inObjectScope(.container)
        
        container.register(APIClient.self) { _ in
            BaseAPIClient(baseUrl: Constants.API.baseUrl)
        }.inObjectScope(.container)
    }
}
