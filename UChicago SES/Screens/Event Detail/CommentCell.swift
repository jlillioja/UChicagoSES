//
//  CommentCell.swift
//  UChicago SES
//
//  Created by Jacob Lillioja on 4/5/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import Foundation
import UIKit

class CommentCell: UIView {
    
    let margin: CGFloat = 10
    
    init(_ comment: Comment) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        let time = UILabel().forCustom()
        time.text = comment.time.toString(format: Style.date.long)
        time.font = Style.font.sans?.withSize(12)
        addSubview(time)
        [
            time.leadingAnchor.constraint(equalTo: leadingAnchor),
            time.trailingAnchor.constraint(equalTo: trailingAnchor),
            time.topAnchor.constraint(equalTo: topAnchor),
        ].activate()
        
        let text = UILabel().forCustom()
        text.text = comment.text
        text.numberOfLines = 0
        text.font = Style.font.sans?.withSize(15)
        addSubview(text)
        [
            text.topAnchor.constraint(equalTo: time.bottomAnchor, constant: margin),
            text.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            text.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin),
            text.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -margin),
        ].activate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

