//
//  ViewController.swift
//  UChicago SES
//
//  Created by Jacob Lillioja on 3/29/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import UIKit
import Firebase

class EventListViewController: UIViewController {
    
    var events: [Event] = []
    
    @IBOutlet weak var eventsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventsTable.dataSource = self
        eventsTable.delegate = self
        
        let db = Database.database().reference()
        
        db.child("events").child("0").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let name = value?["name"] as? String ?? ""
            self.events.append(Event(name: name, time: nil, location: nil, slidesLink: nil))
            
            self.eventsTable.reloadData()
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
//    func deserialize(document: QueryDocumentSnapshot) -> Event {
//        let data = document.data()
//
//        let name = data["name"] as? String
//
//        let timestamp = data["time"] as? Int
//        var date: Date? = nil
//        if let timestamp = timestamp {
//            date = Date(timeIntervalSince1970: TimeInterval(timestamp/1000))
//        }
//
//        let location = data["location"] as? String
//
//        var slidesUrl: URL? = nil
//        let slidesLinkString = data["slidesLink"] as? String
//        if let slidesLinkString = slidesLinkString {
//            slidesUrl = URL(string: slidesLinkString)
//        }
//
//        return Event.init(
//            name: name,
//            time: date,
//            location: location,
//            slidesLink: slidesUrl)
//
//    }
    
}

extension EventListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "EventCell")
        cell.textLabel?.text = events[indexPath.row].name
        cell.accessoryType = .detailButton
        return cell
    }
}

