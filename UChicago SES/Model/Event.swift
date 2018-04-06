//
//  Event.swift
//  UChicago SES
//
//  Created by Jacob Lillioja on 3/29/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Event {
    let snapshot: DataSnapshot
    let name: String
    let time: Date
    let location: String?
    let description: String?
    let link: URL?
}

extension Event {
    static func deserialize(dataSnapshot: DataSnapshot) -> Event? {
        let data = dataSnapshot.value as! NSDictionary
        let name = data["name"] as? String
        if (name == nil) {
            return nil
        }
        
        let timestamp = data["time"] as? Int
        var date: Date? = nil
        if let timestamp = timestamp {
            date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        }
        if (date == nil) {
            return nil
        }
        
        let location = data["location"] as? String
        
        let description = data["description"] as? String
        
        var link: URL? = nil
        let linkString = data["link"] as? String
        if let linkString = linkString {
            link = URL(string: linkString)
        }
        
        return Event(
            snapshot: dataSnapshot,
            name: name!,
            time: date!,
            location: location,
            description: description,
            link: link)
    }
}
