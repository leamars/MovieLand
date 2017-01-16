//
//  QuickMovieDetailLayout.swift
//  MovieLand
//
//  Created by Lea Marolt on 1/16/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import UIKit

extension QuickMovieDetailsViewController {
    func setupConstraints() {
        yourRating.translatesAutoresizingMaskIntoConstraints = false
        
        let yourRatingCenterX = NSLayoutConstraint(
            item: yourRating,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 0.1,
            constant: point.x)
        
        let yourRatingBottom = NSLayoutConstraint(
            item: yourRating,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: view,
            attribute: .top,
            multiplier: 0.1,
            constant: point.y - (2 * starsViewHeight))
        
        let yourRatingHeight = NSLayoutConstraint(
            item: yourRating,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: starsViewHeight)
        
        view.addConstraints([
            yourRatingCenterX,
            yourRatingHeight,
            yourRatingBottom]
        )
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLeading = NSLayoutConstraint(
            item: titleLabel,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: yourRating,
            attribute: .top,
            multiplier: 1.0,
            constant: -10)
        
        let titleCenterX = NSLayoutConstraint(
            item: titleLabel,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: yourRating,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0) //TODO: the 20 could just be a constant for the height
        
        let titleWidth = NSLayoutConstraint(
            item: titleLabel,
            attribute: .width,
            relatedBy: .equal,
            toItem: yourRating,
            attribute: .width,
            multiplier: 1.0,
            constant: 0.0)
        
        view.addConstraints([
            titleLeading,
            titleCenterX,
            titleWidth]
        )
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let containerCenterX = NSLayoutConstraint(
            item: containerView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: yourRating,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
        
        let containerTop = NSLayoutConstraint(
            item: containerView,
            attribute: .top,
            relatedBy: .equal,
            toItem: titleLabel,
            attribute: .top,
            multiplier: 1.0,
            constant: -10.0)
        
        let containerBottom = NSLayoutConstraint(
            item: containerView,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: yourRating,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 10.0)
        
        let containerWidth = NSLayoutConstraint(
            item: containerView,
            attribute: .width,
            relatedBy: .equal,
            toItem: yourRating,
            attribute: .width,
            multiplier: 1.0,
            constant: 20.0)
        
        view.addConstraints([
            containerCenterX,
            containerTop,
            containerBottom,
            containerWidth]
        )
        
        blurView.translatesAutoresizingMaskIntoConstraints = false
        
        let blurCenterX = NSLayoutConstraint(
            item: blurView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: containerView,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
        
        let blurCenterY = NSLayoutConstraint(
            item: blurView,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: containerView,
            attribute: .centerY,
            multiplier: 1.0,
            constant: 0.0)
        
        let blurHeight = NSLayoutConstraint(
            item: blurView,
            attribute: .height,
            relatedBy: .equal,
            toItem: containerView,
            attribute: .height,
            multiplier: 1.0,
            constant: 20.0)
        
        let blurWidth = NSLayoutConstraint(
            item: blurView,
            attribute: .width,
            relatedBy: .equal,
            toItem: containerView,
            attribute: .width,
            multiplier: 1.0,
            constant: 20.0)
        
        containerView.addConstraints([
            blurCenterX,
            blurCenterY,
            blurHeight,
            blurWidth]
        )
    }
}

