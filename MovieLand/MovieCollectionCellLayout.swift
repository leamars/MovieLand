//
//  MovieCollectionCellLayout.swift
//  MovieLand
//
//  Created by Lea Marolt on 1/16/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import UIKit

extension MovieCollectionCell {
    func setupConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let contentWidth = NSLayoutConstraint(
            item: containerView,
            attribute: .width,
            relatedBy: .equal,
            toItem: contentView,
            attribute: .width,
            multiplier: 1.0,
            constant: 0.0)
        
        let contentX = NSLayoutConstraint(
            item: containerView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: contentView,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
        
        let contentY = NSLayoutConstraint(
            item: containerView,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: contentView,
            attribute: .centerY,
            multiplier: 1.0,
            constant: 0.0)
        
        let contentHeight = NSLayoutConstraint(
            item: containerView,
            attribute: .height,
            relatedBy: .equal,
            toItem: contentView,
            attribute: .height,
            multiplier: 1.0,
            constant: 0.0)
        
        contentView.addConstraints([
            contentX,
            contentY,
            contentHeight,
            contentWidth]
        )
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLeft = NSLayoutConstraint(
            item: titleLabel,
            attribute: .left,
            relatedBy: .equal,
            toItem: containerView,
            attribute: .left,
            multiplier: 1.0,
            constant: 10.0)
        
        let titleTop = NSLayoutConstraint(
            item: titleLabel,
            attribute: .top,
            relatedBy: .equal,
            toItem: containerView,
            attribute: .top,
            multiplier: 1.0,
            constant: 20.0)
        
        containerView.addConstraints([
            titleLeft,
            titleTop,
            ]
        )
        
        titleUnderlineView.translatesAutoresizingMaskIntoConstraints = false
        
        let underlineTop = NSLayoutConstraint(
            item: titleUnderlineView,
            attribute: .top,
            relatedBy: .equal,
            toItem: titleLabel,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 3.0)
        
        let underlineHeight = NSLayoutConstraint(
            item: titleUnderlineView,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: 3.0)
        
        let underlineCenterX = NSLayoutConstraint(
            item: titleUnderlineView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: titleLabel,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
        
        let underlineWidth = NSLayoutConstraint(
            item: titleUnderlineView,
            attribute: .width,
            relatedBy: .equal,
            toItem: titleLabel,
            attribute: .width,
            multiplier: 1.0,
            constant: 5.0)
        
        contentView.addConstraints([
            underlineTop,
            underlineWidth,
            underlineHeight,
            underlineCenterX]
        )
        
        movieCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let movieContentWidth = NSLayoutConstraint(
            item: movieCollectionView,
            attribute: .width,
            relatedBy: .equal,
            toItem: contentView,
            attribute: .width,
            multiplier: 1.0,
            constant: 0)
        
        let movieContentX = NSLayoutConstraint(
            item: movieCollectionView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: contentView,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
        
        let movieContentTop = NSLayoutConstraint(
            item: movieCollectionView,
            attribute: .top,
            relatedBy: .equal,
            toItem: titleUnderlineView,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 5.0)
        
        let movieContentBottom = NSLayoutConstraint(
            item: movieCollectionView,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: contentView,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 0)
        
        contentView.addConstraints([
            movieContentX,
            movieContentTop,
            movieContentBottom,
            movieContentWidth]
        )
    }

}
