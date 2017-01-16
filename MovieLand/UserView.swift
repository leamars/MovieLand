//
//  UserView.swift
//  MovieLand
//
//  Created by Lea Marolt on 1/15/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import UIKit

class UserView: UIView {
    
    // Data
    var numberRated: Int {
        didSet {
            updateRatingData()
        }
    }
    var user: User? {
        didSet {
            updateUserData()
        }
    }
    
    // UI
    let nameLabel = UILabel()
    let ratingDescription = UILabel()
    let userMessage = UILabel()
    
    init(with user: User?, numberRated: Int) {
        self.user = user
        self.numberRated = numberRated
        super.init(frame: .zero)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateUserData() {
        guard let userName = user?.name else { return }
        nameLabel.text = "Hello, \(userName)!"
    }
    
    private func updateRatingData() {
        let string = "You've rated \(numberRated) movies."
        let userAttributedString = NSMutableAttributedString(string: string)
        let userAttributedRange = NSRange.init(location: 0, length: string.characters.count)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        userAttributedString.addAttributes(
            [NSFontAttributeName : UIFont.brown(withSize: 14),
             NSParagraphStyleAttributeName : paragraphStyle],
            range: userAttributedRange)
        
        userAttributedString.addAttribute(NSFontAttributeName, value: UIFont.brownBold(withSize: 18), range: NSRange(location: 12, length: 8+String(numberRated).characters.count))
        
        userMessage.attributedText = userAttributedString
    }
    
    private func setupViews() {
        
        // Name
        updateUserData()
        nameLabel.font = UIFont.brownBold(withSize: 20)
        addSubview(nameLabel)
        
        // Rating
        ratingDescription.text = "This is a Fabulous Recommendation Engine."
        ratingDescription.font = UIFont.brown(withSize: 14)
        ratingDescription.numberOfLines = 0
        ratingDescription.textAlignment = .center
        addSubview(ratingDescription)
        
        updateRatingData()
        userMessage.numberOfLines = 0
        addSubview(userMessage)
        
        setupConstraints()
    }

}

extension UserView {
    func setupConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let nameCenterX = NSLayoutConstraint(
            item: nameLabel,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
        
        let nameTop = NSLayoutConstraint(
            item: nameLabel,
            attribute: .top,
            relatedBy: .equal,
            toItem: self,
            attribute: .top,
            multiplier: 1.0,
            constant: 15.0)
        
        addConstraints([
            nameCenterX,
            nameTop]
        )
        
        ratingDescription.translatesAutoresizingMaskIntoConstraints = false
        
        let ratingCenterX = NSLayoutConstraint(
            item: ratingDescription,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
        
        let ratingTop = NSLayoutConstraint(
            item: ratingDescription,
            attribute: .top,
            relatedBy: .equal,
            toItem: nameLabel,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 15.0)
        
        let ratingWidth = NSLayoutConstraint(
            item: ratingDescription,
            attribute: .width,
            relatedBy: .equal,
            toItem: self,
            attribute: .width,
            multiplier: 0.9,
            constant: 0.0)
        
        addConstraints([
            ratingCenterX,
            ratingTop,
            ratingWidth,
            ]
        )
        
        userMessage.translatesAutoresizingMaskIntoConstraints = false
        
        let userCenterX = NSLayoutConstraint(
            item: userMessage,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: ratingDescription,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
        
        let userTop = NSLayoutConstraint(
            item: userMessage,
            attribute: .top,
            relatedBy: .equal,
            toItem: ratingDescription,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 10.0)
        
        let userWidth = NSLayoutConstraint(
            item: userMessage,
            attribute: .width,
            relatedBy: .equal,
            toItem: self,
            attribute: .width,
            multiplier: 0.9,
            constant: 0.0)
        
        
        addConstraints([
            userCenterX,
            userTop,
            userWidth]
        )
    }
}
