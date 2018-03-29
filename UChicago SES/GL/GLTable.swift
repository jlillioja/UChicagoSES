//
//  GLTable.swift
//  UChicago SES
//
//  Created by Jacob Lillioja on 3/29/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import Foundation
import UIKit

class GLTable: UITableView {
    
    var controller: UmbyTableViewController? {
        get { return self._controller }
        set {
            _controller = newValue
            delegate = _controller
            dataSource = _controller
        }
    }
    var _controller: UmbyTableViewController?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero, style: .plain)
        
        forCustom()
        
        layer.cornerRadius = UmbyStyle.smallCornerRadius
        separatorStyle = .none
        allowsMultipleSelection = true
    }
    
    convenience init(_ controller: UmbyTableViewController) {
        self.init()
        self.controller = controller
    }
}
