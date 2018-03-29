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
    
    var controller: GLTableViewController? {
        get { return self._controller }
        set {
            _controller = newValue
            delegate = _controller
            dataSource = _controller
        }
    }
    var _controller: GLTableViewController?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero, style: .plain)
        
        forCustom()
        
        separatorStyle = .none

    }
    
    convenience init(_ controller: GLTableViewController) {
        self.init()
        self.controller = controller
    }
}
