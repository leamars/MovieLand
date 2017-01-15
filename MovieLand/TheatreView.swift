//
//  TheatreView.swift
//  MovieLand
//
//  Created by Lea Marolt on 1/14/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import UIKit

class TheatreView: UIView {
    
    var title: String {
        didSet {
            titleLabel.text = title
        }
    }
    
    var milesAway: Float {
        didSet {
            milesLabel.text = "\(milesAway) miles"
        }
    }
    
    var imageName: String {
        didSet {
            imageView.image = UIImage(named: imageName)
        }
    }
    
    let titleLabel = UILabel()
    let milesLabel = UILabel()
    let imageView = UIImageView()
    
    init(with title: String, distance: Float, imageName:String) {
        self.title = title
        self.milesAway = distance
        self.imageName = imageName
        super.init(frame: .zero)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        // Image View
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.masksToBounds = false
        imageView.layer.shadowOffset = CGSize(width: 0, height: 5)
        imageView.layer.shadowRadius = 5
        imageView.layer.shadowOpacity = 0.2
        addSubview(imageView)
        
        // Title
        titleLabel.font = UIFont.brown(withSize: 16)
        addSubview(titleLabel)
        
        // Miles
        milesLabel.font = UIFont.brown(withSize: 14)
        addSubview(milesLabel)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        let imageCenterX = NSLayoutConstraint(
            item: titleLabel,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
        
        let imageCenterY = NSLayoutConstraint(
            item: titleLabel,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: self,
            attribute: .top,
            multiplier: 1.0,
            constant: 0.0)
        
        let imageHeight = NSLayoutConstraint(
            item: titleLabel,
            attribute: .height,
            relatedBy: .equal,
            toItem: self,
            attribute: .height,
            multiplier: 0.8,
            constant: 0.0)
        
        addConstraints([
            imageCenterY,
            imageCenterX,
            imageHeight]
        )
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let titleCenterX = NSLayoutConstraint(
            item: titleLabel,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: imageView,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
        
        let titleTop = NSLayoutConstraint(
            item: titleLabel,
            attribute: .top,
            relatedBy: .equal,
            toItem: imageView,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 10.0)
        
        addConstraints([
            titleTop,
            titleCenterX]
        )
        
        milesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let milesCenterX = NSLayoutConstraint(
            item: milesLabel,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: titleLabel,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
        
        let milesTop = NSLayoutConstraint(
            item: milesLabel,
            attribute: .top,
            relatedBy: .equal,
            toItem: titleLabel,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 10.0)
        
        addConstraints([
            milesCenterX,
            milesTop]
        )
    }
}
