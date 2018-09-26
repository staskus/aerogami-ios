//
//  Example.swift
//  TravelDataKit
//
//  Created by Povilas Staskus on 9/26/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import UIKit
import TravelKit

public class Example: TravelKit.Example {
    
    public init() {}
    
    public func doStuff() {
        doStuffPrivately()
    }
    
    func doStuffPrivately() {
        print("Hi")
    }
}
