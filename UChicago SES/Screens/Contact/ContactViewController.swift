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
        tabBarController?.navigationItem.title = "Contact"
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
        
        let websiteLink = UILabel().forCustom()
        websiteLink.text = "SES Website"
        websiteLink.font = Style.font.sans?.withSize(16)
        websiteLink.textAlignment = .center
        websiteLink.textColor = Style.colors.teal
        websiteLink.onTap {
            UIApplication.shared.open(URL(string: "http://uchicagoses.org/")!, options: [:], completionHandler: nil)
        }
        container.addArrangedSubview(websiteLink)
        
        let ucpdDescription = UILabel().forCustom()
        ucpdDescription.font = Style.font.sans?.withSize(12)
        ucpdDescription.numberOfLines = 0
        ucpdDescription.text = "For emergencies, please contact the University of Chicago Police Department. To reach:\n\nPress 123 from on-campus phones\nPress the red button on an emergency phone\nCall (773) 702 8181 from other phones."
        container.addArrangedSubview(ucpdDescription)
        
        let ucpdLink = UILabel().forCustom()
        ucpdLink.text = "UCPD: (773) 702 8181"
        ucpdLink.textAlignment = .center
        ucpdLink.textColor = Style.colors.teal
        ucpdLink.onTap {
            UIApplication.shared.open(URL(string: "tel://1-773-702-8181")!, options: [:], completionHandler: nil)
        }
        container.addArrangedSubview(ucpdLink)
        
        let deanOnCallDescription = UILabel().forCustom()
        deanOnCallDescription.text = "One of the resources the University makes available to students is the support and guidance of a University administrator who is on call and can be reached 24 hours a day, 7 days a week. This administrator is called the Dean-on-Call and can be reached by calling (773) 834-HELP (4357) or 4-HELP (4357) from a campus phone."
        deanOnCallDescription.font = Style.font.sans?.withSize(12)
        deanOnCallDescription.numberOfLines = 0
        container.addArrangedSubview(deanOnCallDescription)
        
        let deanOnCallLink = UILabel().forCustom()
        deanOnCallLink.text = "Dean On Call: (773) 834 4357"
        deanOnCallLink.textAlignment = .center
        deanOnCallLink.textColor = Style.colors.teal
        deanOnCallLink.onTap {
            UIApplication.shared.open(URL(string: "tel://1-773-834-4357")!, options: [:], completionHandler: nil)
        }
        container.addArrangedSubview(deanOnCallLink)
    }
    
}
