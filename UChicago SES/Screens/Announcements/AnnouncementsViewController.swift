//
//  AnnouncementsViewController.swift
//  UChicago SES
//
//  Created by Jacob Lillioja on 4/5/18.
//  Copyright © 2018 Jacob Lillioja. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class AnnouncementsViewController: UIViewController {
    
    let margin: CGFloat = 20
    var announcements: [Announcement] = []
    
    var announcementsContainer: UIStackView!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        let tabBarImage = UIImage(named: "announcements")
        tabBarItem = UITabBarItem(title: "Announcements", image: tabBarImage, tag: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        let db = Database.database().reference()
        
        db.child("announcements").observe(.childAdded, with: { (dataSnapshot) -> Void in
            let announcement = Announcement.deserialize(dataSnapshot: dataSnapshot)
            if (announcement != nil) {
                self.addAnnouncement(announcement!)
            }
        })
    }
    
    private func addAnnouncement(_ announcement: Announcement) {
        self.announcements.append(announcement)
        self.announcements.sort(by: { (first, second) -> Bool in
            first.time > second.time
        })
        announcementsContainer.insertArrangedSubview(AnnouncementView(announcement), at: announcements.index(of: announcement)!)
        view.layoutSubviews()
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
        title.text = "ANNOUNCEMENTS"
        title.font = Style.font.sans?.withSize(24)
        title.textAlignment = .center
        container.addArrangedSubview(title)
        
        announcementsContainer = UIStackView().forCustom()
        announcementsContainer.alignment = .fill
        announcementsContainer.axis = .vertical
        announcementsContainer.spacing = margin
        container.addArrangedSubview(announcementsContainer)
    }
    
}
