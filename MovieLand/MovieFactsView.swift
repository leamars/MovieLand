//
//  MovieFactsView.swift
//  MovieLand
//
//  Created by Lea Marolt on 1/15/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import UIKit

class MovieFactsView: UIView {
    
    // Data
    let movie: Movie
    let fontSize: CGFloat
    
    // UI
    let yearLabel = UILabel()
    let admissionRatingFrame = UIView()
    let admissionRatingLabel = UILabel()
    let lengthLabel = UILabel()
    
    init(with movie: Movie, fontSize:CGFloat) {
        self.movie = movie
        self.fontSize = fontSize
        super.init(frame: .zero)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        yearLabel.text = "Year: \(movie.year)"
        admissionRatingLabel.text = "\(movie.admissionRating.rawValue)"
        lengthLabel.text = "\(movie.length) min"
        
        // YEAR:
        yearLabel.font = UIFont.brownBold(withSize: fontSize)
        yearLabel.textColor = UIColor.white
        yearLabel.numberOfLines = 0
        addSubview(yearLabel)
        
        // ADMISSION RATING + FRAME
        admissionRatingLabel.font = UIFont.brownBold(withSize: fontSize)
        admissionRatingLabel.textColor = UIColor.white
        admissionRatingLabel.numberOfLines = 0
        addSubview(admissionRatingLabel)
        
        admissionRatingFrame.layer.borderColor = UIColor.white.cgColor
        admissionRatingFrame.layer.borderWidth = 2
        addSubview(admissionRatingFrame)
        
        // LENGTH:
        lengthLabel.font = UIFont.brownBold(withSize: fontSize)
        lengthLabel.textColor = UIColor.white
        lengthLabel.numberOfLines = 0
        addSubview(lengthLabel)
        
        setupConstraints()
    }
}

extension MovieFactsView {
    func setupConstraints() {
        
        admissionRatingFrame.translatesAutoresizingMaskIntoConstraints = false
        
        let admissionFrameCenterX = NSLayoutConstraint(
            item: admissionRatingFrame,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
        
        let admissionFrameCenterY = NSLayoutConstraint(
            item: admissionRatingFrame,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerY,
            multiplier: 1.0,
            constant: 0.0)
        
        let admissionFrameWidth = NSLayoutConstraint(
            item: admissionRatingFrame,
            attribute: .width,
            relatedBy: .equal,
            toItem: admissionRatingLabel,
            attribute: .width,
            multiplier: 1.0,
            constant: 10.0)
        
        let admissionFrameHeight = NSLayoutConstraint(
            item: admissionRatingFrame,
            attribute: .height,
            relatedBy: .equal,
            toItem: admissionRatingLabel,
            attribute: .height,
            multiplier: 1.0,
            constant: 10.0)
        
        addConstraints([
            admissionFrameCenterX,
            admissionFrameCenterY,
            admissionFrameWidth,
            admissionFrameHeight]
        )
        
        admissionRatingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let admissionRatingCenterY = NSLayoutConstraint(
            item: admissionRatingLabel,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: admissionRatingFrame,
            attribute: .centerY,
            multiplier: 1.0,
            constant: 0.0)
        
        let admissionRatingCenterX = NSLayoutConstraint(
            item: admissionRatingLabel,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: admissionRatingFrame,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
        
        addConstraints([
            admissionRatingCenterY,
            admissionRatingCenterX]
        )
        
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let yearTop = NSLayoutConstraint(
            item: yearLabel,
            attribute: .top,
            relatedBy: .equal,
            toItem: admissionRatingLabel,
            attribute: .top,
            multiplier: 1.0,
            constant: 0.0)
        
        let yearTrailing = NSLayoutConstraint(
            item: yearLabel,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: admissionRatingFrame,
            attribute: .leading,
            multiplier: 1.0,
            constant: -20.0)
        
        addConstraints([
            yearTop,
            yearTrailing]
        )
        
        lengthLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let lengthTop = NSLayoutConstraint(
            item: lengthLabel,
            attribute: .top,
            relatedBy: .equal,
            toItem: admissionRatingLabel,
            attribute: .top,
            multiplier: 1.0,
            constant: 0.0)
        
        let lengthLeading = NSLayoutConstraint(
            item: lengthLabel,
            attribute: .leading,
            relatedBy: .equal,
            toItem: admissionRatingFrame,
            attribute: .trailing,
            multiplier: 1.0,
            constant: 20.0)
        
        addConstraints([
            lengthTop,
            lengthLeading]
        )
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let left = NSLayoutConstraint(
            item: self,
            attribute: .left,
            relatedBy: .equal,
            toItem: yearLabel,
            attribute: .left,
            multiplier: 1.0,
            constant: 0.0)
        
        let right = NSLayoutConstraint(
            item: self,
            attribute: .right,
            relatedBy: .equal,
            toItem: lengthLabel,
            attribute: .right,
            multiplier: 1.0,
            constant: 0.0)
        
        let top = NSLayoutConstraint(
            item: self,
            attribute: .top,
            relatedBy: .equal,
            toItem: admissionRatingFrame,
            attribute: .top,
            multiplier: 1.0,
            constant: 0.0)
        
        let bottom = NSLayoutConstraint(
            item: self,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: admissionRatingFrame,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 0.0)
        
        addConstraints([
            left,
            right,
            top,
            bottom]
        )
    }
}
