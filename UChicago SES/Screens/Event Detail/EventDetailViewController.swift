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
    var comments: [Comment] = []
    let margin: CGFloat = 20
    
    var commentsList: UIStackView!
    
    init(event: Event) {
        self.event = event
        
        super.init(nibName: nil, bundle: nil)
        
        navigationItem.title = event.name
        
        event.snapshot.ref.child("comments").observe(.childAdded) { (dataSnapshot) in
            if let comment = Comment.deserialize(dataSnapshot: dataSnapshot) {
                self.addComment(comment)
            }
        }
    }
    
    var bottomConstraint: NSLayoutConstraint? = nil
    
    override func viewDidLoad() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.accomodateKeyboard(notification:)),
            name: NSNotification.Name.UIKeyboardWillChangeFrame,
            object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func accomodateKeyboard(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
            let animationCurve = UIViewAnimationOptions(rawValue: animationCurveRaw)
            if (endFrame?.origin.y)! >= UIScreen.main.bounds.size.height {
                self.bottomConstraint?.constant = -margin
            } else {
                self.bottomConstraint?.constant = -(endFrame?.size.height ?? 0.0 + margin)
            }
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }
    
    private func addComment(_ comment: Comment) {
        comments.append(comment)
        comments.sort(by: { (first, second) -> Bool in
            first.time < second.time
        })
        commentsList.insertArrangedSubview(CommentCell(comment), at: comments.index(of: comment)!)
//        commentsListHeightConstraint.constant = commentsList.intrinsicContentSize.height
        view.layoutSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
                    scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                ].activate()
//        view.encapsulate(scrollView)
        
        let layout = scrollView.contentLayoutGuide
        
        let container = UIView().forCustom()
        container.setContentHuggingPriority(.required, for: .vertical)
        scrollView.addSubview(container)
        [
            container.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            container.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            container.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            container.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor)
        ].activate()
        
        let name = UILabel().forCustom()
        name.font = Style.font.merriweather
        name.textAlignment = .center
        name.text = event.name
        scrollView.addSubview(name)
        [
            name.topAnchor.constraint(equalTo: container.topAnchor, constant: margin),
            name.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: margin),
            name.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -margin),
        ].activate()
        
        let time = UILabel().forCustom()
        time.text = "Time: \(event.time.toString(format: Style.date.long))"
        time.font = Style.font.sans
        container.addSubview(time)
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
        container.addSubview(location)
        [
            location.topAnchor.constraint(equalTo: time.bottomAnchor, constant: margin),
            location.leadingAnchor.constraint(equalTo: time.leadingAnchor),
            location.trailingAnchor.constraint(equalTo: time.trailingAnchor),
            ].activate()
        
        let description = UILabel().forCustom()
        description.text = event.description
        description.font = Style.font.sans
        description.numberOfLines = 0
        container.addSubview(description)
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
        container.addSubview(link)
        [
            link.topAnchor.constraint(equalTo: description.bottomAnchor, constant: margin),
            link.leadingAnchor.constraint(equalTo: description.leadingAnchor),
            link.trailingAnchor.constraint(equalTo: description.trailingAnchor),
            ].activate()
        
        let commentsTitle = UILabel().forCustom()
        commentsTitle.text = "COMMENTS"
        commentsTitle.font = Style.font.merriweather?.withSize(18)
        commentsTitle.textAlignment = .right
        container.addSubview(commentsTitle)
        [
            commentsTitle.topAnchor.constraint(equalTo: link.bottomAnchor, constant: margin),
            commentsTitle.leadingAnchor.constraint(equalTo: link.leadingAnchor),
            commentsTitle.trailingAnchor.constraint(equalTo: link.trailingAnchor),
//            commentsTitle.bottomAnchor.constraint(equalTo: container.bottomAnchor),
        ].activate()
//
        commentsList = UIStackView().forCustom()
        commentsList.alignment = .leading
        commentsList.axis = .vertical
        commentsList.distribution = .fill
        
        container.addSubview(commentsList)
        [
            commentsList.topAnchor.constraint(equalTo: commentsTitle.bottomAnchor, constant: margin),
            commentsList.leadingAnchor.constraint(equalTo: commentsTitle.leadingAnchor),
            commentsList.trailingAnchor.constraint(equalTo: commentsTitle.trailingAnchor),
            commentsList.bottomAnchor.constraint(equalTo: container.bottomAnchor),
        ].activate()
    }
}
