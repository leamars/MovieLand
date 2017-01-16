//
//  MovieDetailLayout.swift
//  MovieLand
//
//  Created by Lea Marolt on 1/14/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import UIKit

extension MovieDetailViewController {
    func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        
        let imageCenterX = NSLayoutConstraint(
            item: imageView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
        
        let imageCenterY = NSLayoutConstraint(
            item: imageView,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerY,
            multiplier: 1.0,
            constant: 0.0)
        
        let imageHeight = NSLayoutConstraint(
            item: imageView,
            attribute: .height,
            relatedBy: .equal,
            toItem: view,
            attribute: .height,
            multiplier: 1.0,
            constant: 0.0)
        
        let imageWidth = NSLayoutConstraint(
            item: imageView,
            attribute: .width,
            relatedBy: .equal,
            toItem: view,
            attribute: .width,
            multiplier: 1.0,
            constant: 0.0)
        
        view.addConstraints([
            imageCenterY,
            imageCenterX,
            imageHeight,
            imageWidth]
        )
        
//        closeButton.translatesAutoresizingMaskIntoConstraints = false
//        
//        let buttonTop = NSLayoutConstraint(
//            item: closeButton,
//            attribute: .top,
//            relatedBy: .equal,
//            toItem: view,
//            attribute: .top,
//            multiplier: 1.0,
//            constant: 20.0)
//        
//        let buttonRight = NSLayoutConstraint(
//            item: closeButton,
//            attribute: .trailing,
//            relatedBy: .equal,
//            toItem: view,
//            attribute: .trailing,
//            multiplier: 1.0,
//            constant: -20.0)
//        
//        view.addConstraints([
//            buttonTop,
//            buttonRight]
//        )
        
        addTopContainerViewConstraints()
        addBottomContainerViewConstraints()
    }
    
    func addTopContainerViewConstraints() {
        
        topDetailView.translatesAutoresizingMaskIntoConstraints = false
        
        let topContainerCenterX = NSLayoutConstraint(
            item: topDetailView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
        
        let topContainer = NSLayoutConstraint(
            item: topDetailView,
            attribute: .top,
            relatedBy: .equal,
            toItem: view,
            attribute: .top,
            multiplier: 1.0,
            constant: 0.0)
        
        let topContainerHeight = NSLayoutConstraint(
            item: topDetailView,
            attribute: .height,
            relatedBy: .equal,
            toItem: view,
            attribute: .height,
            multiplier: 0.5,
            constant: 0.0)
        
        let topContainerWidth = NSLayoutConstraint(
            item: topDetailView,
            attribute: .width,
            relatedBy: .equal,
            toItem: view,
            attribute: .width,
            multiplier: 1.0,
            constant: 0.0)
        
        view.addConstraints([
            topContainerCenterX,
            topContainer,
            topContainerHeight,
            topContainerWidth]
        )
        
    }
    
    func addBottomContainerViewConstraints() {
        
        bottomDetailView.translatesAutoresizingMaskIntoConstraints = false
        
        let bottomContainerCenterX = NSLayoutConstraint(
            item: bottomDetailView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
        
        let bottomContainer = NSLayoutConstraint(
            item: bottomDetailView,
            attribute: .top,
            relatedBy: .equal,
            toItem: topDetailView,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 0.0)
        
        let bottomContainerHeight = NSLayoutConstraint(
            item: bottomDetailView,
            attribute: .height,
            relatedBy: .equal,
            toItem: view,
            attribute: .height,
            multiplier: 0.5,
            constant: 0.0)
        
        let bottomContainerWidth = NSLayoutConstraint(
            item: bottomDetailView,
            attribute: .width,
            relatedBy: .equal,
            toItem: view,
            attribute: .width,
            multiplier: 1.0,
            constant: 0.0)
        
        view.addConstraints([
            bottomContainerCenterX,
            bottomContainer,
            bottomContainerHeight,
            bottomContainerWidth]
        )

        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        let buttonBottom = NSLayoutConstraint(
            item: closeButton,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: bottomDetailView,
            attribute: .bottom,
            multiplier: 1.0,
            constant: -20.0)
        
        let buttonRight = NSLayoutConstraint(
            item: closeButton,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: bottomDetailView,
            attribute: .trailing,
            multiplier: 1.0,
            constant: -20.0)
        
        bottomDetailView.addConstraints([
            buttonBottom,
            buttonRight]
        )
        
    }
}
