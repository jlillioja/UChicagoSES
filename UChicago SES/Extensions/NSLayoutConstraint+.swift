//
//  NSLayoutConstraint+.swift
//  umby
//
//  Created by Jacob Lillioja on 3/5/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import Foundation
import UIKit

extension NSLayoutConstraint {
    func activate() {
        NSLayoutConstraint.activate([self])
    }
}
