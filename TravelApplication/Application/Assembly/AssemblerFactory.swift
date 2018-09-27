//
//  AssemblerFactory.swift
//  TravelApplication
//
//  Created by Povilas Staskus on 9/26/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import Foundation
import Swinject

class AssemblerFactory {
    
    func create() -> Assembler {
        let assemblies: [Assembly] = [
            ApplicationAssembly()
        ]
        
        let assembler = Assembler(assemblies)
        
        return assembler
    }
}
