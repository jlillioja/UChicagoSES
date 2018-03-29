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
    let margin: CGFloat = 15
    
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
        name.text = event.name
        view.addSubview(name)
        [
            name.topAnchor.constraint(equalTo: layout.topAnchor, constant: margin),
            name.leadingAnchor.constraint(equalTo: layout.leadingAnchor, constant: margin),
            name.trailingAnchor.constraint(equalTo: layout.trailingAnchor, constant: -margin),
        ].activate()
        
        let location = UILabel().forCustom()
        location.text = event.location
        location.textColor = Style.colors.teal
        view.addSubview(location)
        if let locationString = event.location {
            let baseUrl: String = "http://maps.apple.com/?q="
            let encodedName = locationString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let finalUrl = baseUrl + encodedName
            if let url = URL(string: finalUrl)
            {
                location.onTap {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }
        [
            location.topAnchor.constraint(equalTo: name.bottomAnchor, constant: margin),
            location.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            location.trailingAnchor.constraint(equalTo: name.trailingAnchor),
        ].activate()
        
        let time = UILabel().forCustom()
        time.text = event.time?.toString(dateStyle: .medium, timeStyle: .medium)
        view.addSubview(time)
        [
            time.topAnchor.constraint(equalTo: location.bottomAnchor, constant: margin),
            time.leadingAnchor.constraint(equalTo: location.leadingAnchor),
            time.trailingAnchor.constraint(equalTo: location.trailingAnchor)
        ].activate()
        
        let slidesLink = UILabel().forCustom()
        slidesLink.text = event.slidesLink?.absoluteString
        slidesLink.textColor = Style.colors.teal
        if let url = event.slidesLink {
            slidesLink.onTap {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        view.addSubview(slidesLink)
        [
            slidesLink.topAnchor.constraint(equalTo: time.bottomAnchor, constant: margin),
            slidesLink.leadingAnchor.constraint(equalTo: time.leadingAnchor),
            slidesLink.trailingAnchor.constraint(equalTo: time.trailingAnchor),
            slidesLink.bottomAnchor.constraint(lessThanOrEqualTo: layout.bottomAnchor),
        ].activate()
    }
}
