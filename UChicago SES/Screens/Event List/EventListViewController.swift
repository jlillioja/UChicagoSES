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
    
    var eventsTable: GLTable! = nil
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .white
        
        let layout = view.safeAreaLayoutGuide
        
        let title = UILabel().forCustom()
        title.text = "EVENTS"
        title.font = UIFont(name: "OpenSans-Regular", size: 24)
        title.textAlignment = .center
        view.addSubview(title)
        [
            title.topAnchor.constraint(equalTo: layout.topAnchor, constant: 10),
            title.leadingAnchor.constraint(equalTo: layout.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: layout.trailingAnchor)
        ].activate()
        
        eventsTable = GLTable(self)
        eventsTable.insetsContentViewsToSafeArea = true
        view.addSubview(eventsTable)
        [
            eventsTable.topAnchor.constraint(equalTo: title.bottomAnchor),
            eventsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            eventsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            eventsTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ].activate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        navigationItem.title = "Schedule"
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        let db = Database.database().reference()
        
        db.child("events").observe(.childAdded, with: { (dataSnapshot) -> Void in
            let event = Event.deserialize(dataSnapshot: dataSnapshot)
            if (event != nil) {
                self.events.append(event!)
                self.events.sort(by: { (first, second) -> Bool in
                    first.time < second.time
                })
                self.eventsTable.reloadData()
            }
        })
    }
}

extension EventListViewController: GLTableViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = EventCell(events[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        eventsTable.cellForRow(at: indexPath)?.setSelected(false, animated: true)
        
        let eventDetailViewController = EventDetailViewController(event: events[indexPath.row])
        navigationController?.pushViewController(eventDetailViewController, animated: true)
    }
}

