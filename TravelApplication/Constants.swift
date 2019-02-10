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
        static let baseUrl: String = {
            return valueForAPIKey(keyname: "BASE_URL") ?? "BASE_URL"
        }()
    }

    #else

    static let environment = Environment.production

    struct API {
        static let baseUrl: String = {
            return valueForAPIKey(keyname: "BASE_URL") ?? "BASE_URL"
        }()
    }

    #endif

    static let affiliateId = {
        return valueForAPIKey(keyname: "AFFILIATE_ID") ?? "AFFILIATE_ID"
    }()
}

private func valueForAPIKey(keyname: String) -> String? {
    guard let filePath = Bundle.main.path(forResource: "Keys", ofType: "plist"),
          let plist = NSDictionary(contentsOfFile: filePath),
          let value = plist.object(forKey: keyname) as? String else {
        return nil
    }

    return value
}
