//
//  Style.swift
//  UChicago SES
//
//  Created by Jacob Lillioja on 3/29/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import Foundation
import UIKit

struct Style {
    struct colors {
        static let teal = UIColor(r: 88, g: 202, b: 250)
    }
    
    struct date {
        static let short = "E, h:mm"
        static let long = "EE, MMMd, h:mm"
    }
    
    struct font {
        static let merriweather = UIFont(name: "Merriweather-Regular", size: 24)
        static let sans = UIFont(name: "OpenSans-Regular", size: 15)
    }
}
