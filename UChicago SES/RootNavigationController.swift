//
//  RootNavigationController.swift
//  UChicago SES
//
//  Created by Jacob Lillioja on 3/29/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import Foundation
import UIKit

class RootNavigationController: UINavigationController {
    
    let entryListViewController = EventListViewController()
    
    override func viewDidLoad() {
        
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = Style.colors.teal
        
        setViewControllers([entryListViewController], animated: false)
    }
}
