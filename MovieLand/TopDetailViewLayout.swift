//
//  TopDetailViewLayout.swift
//  MovieLand
//
//  Created by Lea Marolt on 1/16/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import UIKit

extension TopDetailView {
    func setupConstraints() {
        overallLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let overallTop = NSLayoutConstraint(
            item: overallLabel,
            attribute: .top,
            relatedBy: .equal,
            toItem: self,
            attribute: .top,
            multiplier: 1.0,
            constant: 30.0)
        
        let overallCenterX = NSLayoutConstraint(
            item: overallLabel,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
        
        let overallWidth = NSLayoutConstraint(
            item: overallLabel,
            attribute: .width,
            relatedBy: .equal,
            toItem: self,
            attribute: .width,
            multiplier: 0.8,
            constant: 0.0)
        
        addConstraints([
            overallTop,
            overallCenterX,
            overallWidth]
        )
        
        overallRatingView.translatesAutoresizingMaskIntoConstraints = false
        
        let overallRatingTop = NSLayoutConstraint(
            item: overallRatingView,
            attribute: .top,
            relatedBy: .equal,
            toItem: overallLabel,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 20.0)
        
        let overallRatingCenterX = NSLayoutConstraint(
            item: overallRatingView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: overallLabel,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
        
        let overallRatingHeight = NSLayoutConstraint(
            item: overallRatingView,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: 20.0)
        
        addConstraints([
            overallRatingTop,
            overallRatingCenterX,
            overallRatingHeight]
        )
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let titleTop = NSLayoutConstraint(
            item: titleLabel,
            attribute: .top,
            relatedBy: .equal,
            toItem: overallRatingView,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 20.0)
        
        let titleCenterX = NSLayoutConstraint(
            item: titleLabel,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: overallRatingView,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
        
        let titleWidth = NSLayoutConstraint(
            item: titleLabel,
            attribute: .width,
            relatedBy: .equal,
            toItem: self,
            attribute: .width,
            multiplier: 0.8,
            constant: 0.0)
        
        addConstraints([
            titleTop,
            titleCenterX,
            titleWidth]
        )
        
        factsView.translatesAutoresizingMaskIntoConstraints = false
        
        let factsTop = NSLayoutConstraint(
            item: factsView,
            attribute: .top,
            relatedBy: .equal,
            toItem: titleLabel,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 20.0)
        
        let factsCenterX = NSLayoutConstraint(
            item: factsView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: titleLabel,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
        
        addConstraints([
            factsTop,
            factsCenterX]
        )
        
        predictionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let predictionRatingTop = NSLayoutConstraint(
            item: predictionLabel,
            attribute: .top,
            relatedBy: .equal,
            toItem: factsView,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 40.0)
        
        let predictionRatingCenterX = NSLayoutConstraint(
            item: predictionLabel,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: factsView,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
        
        addConstraints([
            predictionRatingTop,
            predictionRatingCenterX]
        )
        
        yourRating.translatesAutoresizingMaskIntoConstraints = false
        
        let yourRatingTop = NSLayoutConstraint(
            item: yourRating,
            attribute: .top,
            relatedBy: .equal,
            toItem: predictionLabel,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 20.0)
        
        let yourRatingCenterX = NSLayoutConstraint(
            item: yourRating,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: predictionLabel,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
        
        let yourRatingHeight = NSLayoutConstraint(
            item: yourRating,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: 40.0)
        
        addConstraints([
            yourRatingTop,
            yourRatingCenterX,
            yourRatingHeight]
        )
    }
}

