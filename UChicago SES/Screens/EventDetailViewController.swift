//
//  EventDetailViewController.swift
//  UChicago SES
//
//  Created by Jacob Lillioja on 3/29/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import Foundation
import UIKit

class EventDetailViewController: UIViewController {
    
    let event: Event
    let margin: CGFloat = 20
    
    init(event: Event) {
        self.event = event
        
        super.init(nibName: nil, bundle: nil)
        
        navigationItem.title = event.name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        
        let layout = view.safeAreaLayoutGuide
        
        let name = UILabel().forCustom()
        name.font = Style.font.merriweather
        name.textAlignment = .center
        name.text = event.name
        view.addSubview(name)
        [
            name.topAnchor.constraint(equalTo: layout.topAnchor, constant: margin),
            name.leadingAnchor.constraint(equalTo: layout.leadingAnchor, constant: margin),
            name.trailingAnchor.constraint(equalTo: layout.trailingAnchor, constant: -margin),
        ].activate()
    
        let time = UILabel().forCustom()
        time.text = "Time: \(event.time.toString(format: Style.date.long))"
        time.font = Style.font.sans
        view.addSubview(time)
        [
            time.topAnchor.constraint(equalTo: name.bottomAnchor, constant: margin),
            time.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            time.trailingAnchor.constraint(equalTo: name.trailingAnchor)
        ].activate()
        
        let location = UILabel().forCustom()
        location.font = Style.font.sans
        if let locationString = event.location {
            location.text = "Location: \(locationString)"
            location.textColor = Style.colors.teal
            let baseUrl: String = "http://maps.apple.com/?q="
            let encodedName = locationString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let finalUrl = baseUrl + encodedName
            if let url = URL(string: finalUrl)
            {
                location.onTap {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        } else {
            location.text = "Location: TBD"
        }
        view.addSubview(location)
        [
            location.topAnchor.constraint(equalTo: time.bottomAnchor, constant: margin),
            location.leadingAnchor.constraint(equalTo: time.leadingAnchor),
            location.trailingAnchor.constraint(equalTo: time.trailingAnchor),
        ].activate()

        let description = UILabel().forCustom()
        description.text = event.description
        description.font = Style.font.sans
        description.numberOfLines = 0
        view.addSubview(description)
        [
            description.topAnchor.constraint(equalTo: location.bottomAnchor, constant: margin),
            description.leadingAnchor.constraint(equalTo: location.leadingAnchor),
            description.trailingAnchor.constraint(equalTo: location.trailingAnchor),
        ].activate()
        
        let link = UILabel().forCustom()
        link.text = event.link?.absoluteString
        link.font = Style.font.sans
        link.textColor = Style.colors.teal
        if let url = event.link {
            link.onTap {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        view.addSubview(link)
        [
            link.topAnchor.constraint(equalTo: description.bottomAnchor, constant: margin),
            link.leadingAnchor.constraint(equalTo: description.leadingAnchor),
            link.trailingAnchor.constraint(equalTo: description.trailingAnchor),
            link.bottomAnchor.constraint(lessThanOrEqualTo: layout.bottomAnchor),
        ].activate()
    }
}
