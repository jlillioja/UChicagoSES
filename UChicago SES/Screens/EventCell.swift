//
//  EventCell.swift
//  UChicago SES
//
//  Created by Jacob Lillioja on 3/29/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import Foundation
import UIKit

class EventCell: UITableViewCell {
    static let reuseIdentifier = "EventCell"
    
    let margin: CGFloat = 10
    
    init(_ event: Event) {
        
        super.init(style: .default, reuseIdentifier: EventCell.reuseIdentifier)
        
        let name = UILabel().forCustom()
        name.text = event.name ?? ""
        name.adjustsFontSizeToFitWidth = true
        addSubview(name)
        [
            name.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: margin),
            name.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: margin),
            name.trailingAnchor.constraint(equalTo: accessoryView?.leadingAnchor ?? safeAreaLayoutGuide.trailingAnchor, constant: -margin),
        ].activate()
        
        let location = UILabel().forCustom()
        location.text = event.location ?? ""
        location.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        name.adjustsFontSizeToFitWidth = true
        addSubview(location)
        [
            location.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            location.trailingAnchor.constraint(equalTo: name.trailingAnchor),
            location.topAnchor.constraint(equalTo: name.bottomAnchor, constant: margin),
            location.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -margin)
        ].activate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
