//
//  Announcement.swift
//  UChicago SES
//
//  Created by Jacob Lillioja on 4/5/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Announcement: Equatable {
    let text: String
    let time: Date
    
    static func deserialize(dataSnapshot: DataSnapshot) -> Announcement? {
        let data = dataSnapshot.value as! NSDictionary
        if let text = data["text"] as? String,
            let time = data["time"] as? Double {
            return Announcement(text: text, time: Date(timeIntervalSince1970: TimeInterval(time.rounded())))
        } else {
            return nil
        }
    }
}
