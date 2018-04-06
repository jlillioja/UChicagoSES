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
    let name: String
    let time: Date
    let location: String?
    let description: String?
    let link: URL?
    let comments: DatabaseReference
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
            name: name!,
            time: date!,
            location: location,
            description: description,
            link: link,
            comments: dataSnapshot.childSnapshot(forPath: "comments").ref
        )
    }
}
