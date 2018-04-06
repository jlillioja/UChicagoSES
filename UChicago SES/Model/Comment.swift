//
//  Comment.swift
//  UChicago SES
//
//  Created by Jacob Lillioja on 4/5/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Comment: Equatable {
    let text: String
    let time: Date
}

extension Comment {
    static func deserialize(dataSnapshot: DataSnapshot) -> Comment? {
        let data = dataSnapshot.value as! NSDictionary
        
        if let text = data["text"] as? String,
            let timestamp = data["time"] as? Int {
            let time = Date(timeIntervalSince1970: TimeInterval(timestamp))
            return Comment(text: text, time: time)
        } else {
            return nil
        }
    }
}
