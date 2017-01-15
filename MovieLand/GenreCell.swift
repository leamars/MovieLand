//
//  GenreView.swift
//  MovieLand
//
//  Created by Lea Marolt on 1/11/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import UIKit

class GenreCell: UICollectionViewCell {
    
    static let identifier = "GenreCell"
    
    var nameLabel = UILabel()
    var underlineView = UIView()
    var name:String? {
        didSet {
            let attributedString = NSMutableAttributedString(string: name!.uppercased())
            attributedString.addAttributes([NSKernAttributeName : 0.0], range: NSRange(location: 0, length: name!.characters.count))
            nameLabel.attributedText = attributedString
        }
    }
    var added: Bool {
        didSet {
            if added {
                backgroundColor = UIColor.white.withAlphaComponent(0.5)
                underlineView.backgroundColor = UIColor.black
                layer.borderColor = UIColor.black.cgColor
                layer.borderWidth = 2
            } else {
                backgroundColor = UIColor.clear
                layer.borderColor = UIColor.clear.cgColor
                underlineView.backgroundColor = UIColor.clear
            }
        }
    }
    
    
    override init(frame: CGRect) {
        self.added = false
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        // Genre name
        nameLabel.font = UIFont.brown(withSize: 12)
        addSubview(nameLabel)
        
        // underline view
        addSubview(underlineView)
        underlineView.backgroundColor = UIColor.black
        
        setupConstraints()
    }
    
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
        
        let nameCenterY = NSLayoutConstraint(
            item: nameLabel,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerY,
            multiplier: 1.0,
            constant: 0.0)
        
        addConstraints([
            nameCenterX,
            nameCenterY]
        )
        
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        
        let underlineCenterX = NSLayoutConstraint(
            item: underlineView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
        
        let underlineBottom = NSLayoutConstraint(
            item: underlineView,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: self,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 0.0)
        
        let underlineHeight = NSLayoutConstraint(
            item: underlineView,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: 5.0)
        
        addConstraints([
            underlineCenterX,
            underlineBottom,
            underlineHeight]
        )
    }
}
