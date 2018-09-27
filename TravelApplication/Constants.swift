//
//  Constants.swift
//  TravelApplication
//
//  Created by Povilas Staskus on 9/26/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import UIKit

enum Environment {
    case development
    case production
}


struct Constants {
    #if DEVELOPMENT
    
    static let environment = Environment.development
    
    struct API {
        static let baseUrl = "https://48n584gglk.execute-api.eu-central-1.amazonaws.com/dev"
    }
    
    #else

    static let environment = Environment.production
    
    struct API {
        static let baseUrl = "https://48n584gglk.execute-api.eu-central-1.amazonaws.com/dev"
    }
    
    #endif
}

