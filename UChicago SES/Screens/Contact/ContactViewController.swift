//
//  ContactViewController.swift
//  UChicago SES
//
//  Created by Jacob Lillioja on 4/6/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import Foundation
import UIKit

class ContactViewController: UIViewController {
    
    let margin: CGFloat = 20
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        let tabBarImage = UIImage(named: "contact")
        tabBarItem = UITabBarItem(title: "Contact", image: tabBarImage, tag: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.navigationItem.title = "Announcements"
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        tabBarController?.navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        
        let scrollView = UIScrollView().forCustom()
        view.addSubview(scrollView)
        [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ].activate()
        
        let container = UIStackView().forCustom()
        container.alignment = .fill
        container.axis = .vertical
        container.spacing = margin
        scrollView.addSubview(container)
        [
            container.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: margin),
            container.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: margin),
            container.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -margin),
            container.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -margin)
            ].activate()
        
        let title = UILabel().forCustom()
        title.text = "CONTACTS"
        title.font = Style.font.sans?.withSize(24)
        title.textAlignment = .center
        container.addArrangedSubview(title)
        
        let ucpd = UILabel().forCustom()
        ucpd.text = "UCPD"
        ucpd.onTap {
//            UIApplication.shared.open(URL(string: "tel://911")!, options: [:], completionHandler: nil)
        }
        container.addArrangedSubview(ucpd)
        
        let ucpdLink = UITextView().forCustom()
        ucpdLink.text = "911"
        ucpdLink.isEditable = false
        ucpdLink.isUserInteractionEnabled = true
        ucpdLink.dataDetectorTypes = UIDataDetectorTypes.phoneNumber
        container.addArrangedSubview(ucpdLink)
        
        let deanOnCallTitle = UILabel().forCustom()
        deanOnCallTitle.text = "Dean On Call"
        container.addArrangedSubview(deanOnCallTitle)
        
    }
    
}
