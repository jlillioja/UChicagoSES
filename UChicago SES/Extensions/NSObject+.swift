//
//  NSObject+.swift
//  umby
//
//  Created by Jacob Lillioja on 3/5/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import Foundation

extension NSObject {
    func apply<T>(_ closure: (T) -> Void) -> Self {
        if (self is T) {
            closure(self as! T)
        } else {
            print("You gave me a bad function bucko")
        }
        return self
    }
}
