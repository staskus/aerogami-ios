//
//  AssemblerFactory.swift
//  TravelApplication
//
//  Created by Povilas Staskus on 9/26/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import Foundation
import Swinject
import TravelFeatureKit

class AssemblerFactory {
    
    func create() -> Assembler {
        let assemblies: [Assembly] = [
            ApplicationAssembly(),
            HomeAssembly(),
            FeedAssembly()
        ]
        
        let assembler = Assembler(assemblies)
        
        return assembler
    }
}
