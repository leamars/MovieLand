//
//  TheatreView.swift
//  MovieLand
//
//  Created by Lea Marolt on 1/14/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import UIKit

protocol TheatreViewDelegate: class {
    func didTapOnTheatre(theatre: TheatreView)
}

class TheatreView: UIView {
    
    weak var delegate: TheatreViewDelegate?
    
    // Data
    var title: String
    var milesAway: Float
    var imageName: String
    
    // UI
    private let titleLabel = UILabel()
    private let milesLabel = UILabel()
    private let imageView = UIImageView()
    
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
        
    private func setupData() {
        titleLabel.text = title
        milesLabel.text = "\(milesAway) miles"
        imageView.image = UIImage(named: imageName)
    }
    
    private func setUpGestures() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func viewTapped() {
        guard let delegate = delegate else { return }
        delegate.didTapOnTheatre(theatre: self)
    }
    
    private func setupViews() {
        
        setUpGestures()
        setupData()
        
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
    
    private func setupConstraints() {
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        let imageCenterX = NSLayoutConstraint(
            item: imageView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
        
        let imageTop = NSLayoutConstraint(
            item: imageView,
            attribute: .top,
            relatedBy: .equal,
            toItem: self,
            attribute: .top,
            multiplier: 1.0,
            constant: 0.0)
        
        addConstraints([
            imageTop,
            imageCenterX]
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
        
        let viewTrailing = NSLayoutConstraint(
            item: self,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: imageView,
            attribute: .trailing,
            multiplier: 1.0,
            constant: 5.0)
        
        let viewBottom = NSLayoutConstraint(
            item: self,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: milesLabel,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 0.0)
        
        addConstraints([
            viewTrailing,
            viewBottom]
        )
    }
}
