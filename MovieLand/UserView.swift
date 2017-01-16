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
    let numberRated: Int
    
    // UI
    let nameLabel = UILabel()
    let ratingDescription = UILabel()
    let userMessage = UILabel()
    
    enum MessageForNumber: Int {
        case Surface = 1
        case Crawling = 10
        case Connoseur = 25
        case Force = 50
        
        func message() -> String {
            switch self {
            case .Surface:
                return "You've scratched the surface. Movie greatness abound awaits!"
            case .Crawling:
                return "You've watched a couple of movies. But you're still barely just beginning."
            case .Connoseur:
                return "Oh hello, madam! How may we serve you today?"
            case .Force:
                return "You're a force to be reckoned with! Enjoy your browsing glory."
            }
        }
    }
    
    init(numberRated: Int) {
        self.numberRated = numberRated
        super.init(frame: .zero)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        // Name
        nameLabel.text = "Hello, Lea!"
        nameLabel.font = UIFont.brownBold(withSize: 20)
        addSubview(nameLabel)
        
        // Rating
        ratingDescription.text = "You are using the Pikachu Recommendation Engine. It uses item-to-item collaborative filtering to deliver you the best results possible. \nGotta catch 'em allg yg p!"
        ratingDescription.font = UIFont.brown(withSize: 14)
        ratingDescription.numberOfLines = 0
        ratingDescription.textAlignment = .center
        addSubview(ratingDescription)
        
        // User Message
        var message: MessageForNumber
        if numberRated < 10 {
            message = MessageForNumber.Surface
        } else if numberRated < 25 {
            message = MessageForNumber.Crawling
        } else if numberRated < 50 {
            message = MessageForNumber.Connoseur
        } else {
            message = MessageForNumber.Force
        }
        
        let string = "You've rated \(numberRated) movies."
        let userAttributedString = NSMutableAttributedString(string: string)
        let userAttributedRange = NSRange.init(location: 0, length: string.characters.count)
        userAttributedString.addAttributes(
            [NSFontAttributeName : UIFont.brown(withSize: 14)],
            range: userAttributedRange)
        userAttributedString.addAttributes([NSFontAttributeName : UIFont.brownBold(withSize: 18)], range: NSRange(location: 12, length: 8+String(numberRated).characters.count))
        
        userMessage.attributedText = userAttributedString
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
