//
//  EmptyView.swift
//  TravelFeatureKit
//
//  Created by Povilas Staskus on 9/27/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import UIKit

class EmptyView: UIView {
    init() {
        super.init(frame: .zero)
        backgroundColor = .blue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
