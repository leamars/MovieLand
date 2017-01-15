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
        
        topContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        let topContainerCenterX = NSLayoutConstraint(
            item: topContainerView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
        
        let topContainer = NSLayoutConstraint(
            item: topContainerView,
            attribute: .top,
            relatedBy: .equal,
            toItem: view,
            attribute: .top,
            multiplier: 1.0,
            constant: 0.0)
        
        let topContainerHeight = NSLayoutConstraint(
            item: topContainerView,
            attribute: .height,
            relatedBy: .equal,
            toItem: view,
            attribute: .height,
            multiplier: 0.5,
            constant: 0.0)
        
        let topContainerWidth = NSLayoutConstraint(
            item: topContainerView,
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
        
        overallLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let overallTop = NSLayoutConstraint(
            item: overallLabel,
            attribute: .top,
            relatedBy: .equal,
            toItem: topContainerView,
            attribute: .top,
            multiplier: 1.0,
            constant: 30.0)
        
        let overallCenterX = NSLayoutConstraint(
            item: overallLabel,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: topContainerView,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
        
        let overallWidth = NSLayoutConstraint(
            item: overallLabel,
            attribute: .width,
            relatedBy: .equal,
            toItem: topContainerView,
            attribute: .width,
            multiplier: 0.8,
            constant: 0.0)
        
        topContainerView.addConstraints([
            overallTop,
            overallCenterX,
            overallWidth]
        )
        
        //TODO: Overall Rating
        overallRatingView.translatesAutoresizingMaskIntoConstraints = false
        
        let overallRatingTop = NSLayoutConstraint(
            item: overallRatingView,
            attribute: .top,
            relatedBy: .equal,
            toItem: overallLabel,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 30.0)
        
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
        
        let overallRatingWidth = NSLayoutConstraint(
            item: overallRatingView,
            attribute: .width,
            relatedBy: .equal,
            toItem: topContainerView,
            attribute: .width,
            multiplier: 1.0,
            constant: 0.0)
        
        topContainerView.addConstraints([
            overallRatingTop,
            overallRatingCenterX,
            overallRatingHeight,
            overallRatingWidth]
        )
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let titleTop = NSLayoutConstraint(
            item: titleLabel,
            attribute: .top,
            relatedBy: .equal,
            toItem: overallRatingView,
            attribute: .top,
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
            toItem: topContainerView,
            attribute: .width,
            multiplier: 0.8,
            constant: 0.0)
        
        topContainerView.addConstraints([
            titleTop,
            titleCenterX,
            titleWidth]
        )
        
        admissionRatingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let admissionRatingTop = NSLayoutConstraint(
            item: admissionRatingLabel,
            attribute: .top,
            relatedBy: .equal,
            toItem: titleLabel,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 20.0)
        
        let admissionRatingCenterX = NSLayoutConstraint(
            item: admissionRatingLabel,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: titleLabel,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
        
        topContainerView.addConstraints([
            admissionRatingTop,
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
            toItem: admissionRatingLabel,
            attribute: .leading,
            multiplier: 1.0,
            constant: -10.0)
        
        topContainerView.addConstraints([
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
            toItem: admissionRatingLabel,
            attribute: .trailing,
            multiplier: 1.0,
            constant: 10.0)
        
        topContainerView.addConstraints([
            lengthTop,
            lengthLeading]
        )

        predictionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let predictionRatingTop = NSLayoutConstraint(
            item: predictionLabel,
            attribute: .top,
            relatedBy: .equal,
            toItem: admissionRatingLabel,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 20.0)
        
        let predictionRatingCenterX = NSLayoutConstraint(
            item: predictionLabel,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: admissionRatingLabel,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
        
        topContainerView.addConstraints([
            predictionRatingTop,
            predictionRatingCenterX]
        )
        
    }
    
    func addBottomContainerViewConstraints() {
        
        bottomContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        let bottomContainerCenterX = NSLayoutConstraint(
            item: bottomContainerView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
        
        let bottomContainer = NSLayoutConstraint(
            item: bottomContainerView,
            attribute: .top,
            relatedBy: .equal,
            toItem: topContainerView,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 0.0)
        
        let bottomContainerHeight = NSLayoutConstraint(
            item: bottomContainerView,
            attribute: .height,
            relatedBy: .equal,
            toItem: view,
            attribute: .height,
            multiplier: 0.5,
            constant: 0.0)
        
        let bottomContainerWidth = NSLayoutConstraint(
            item: bottomContainerView,
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
            toItem: bottomContainerView,
            attribute: .bottom,
            multiplier: 1.0,
            constant: -20.0)
        
        let buttonRight = NSLayoutConstraint(
            item: closeButton,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: bottomContainerView,
            attribute: .trailing,
            multiplier: 1.0,
            constant: -20.0)
        
        bottomContainerView.addConstraints([
            buttonBottom,
            buttonRight]
        )
        
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let genreTop = NSLayoutConstraint(
            item: genreLabel,
            attribute: .top,
            relatedBy: .equal,
            toItem: bottomContainerView,
            attribute: .top,
            multiplier: 1.0,
            constant: 20.0)
        
        let genreLeading = NSLayoutConstraint(
            item: genreLabel,
            attribute: .leading,
            relatedBy: .equal,
            toItem: bottomContainerView,
            attribute: .leading,
            multiplier: 1.0,
            constant: 20.0)
        
        let genreWidth = NSLayoutConstraint(
            item: genreLabel,
            attribute: .width,
            relatedBy: .equal,
            toItem: bottomContainerView,
            attribute: .width,
            multiplier: 0.8,
            constant: 0.0)
        
        bottomContainerView.addConstraints([
            genreTop,
            genreLeading,
            genreWidth]
        )

        languagesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let languagesTop = NSLayoutConstraint(
            item: languagesLabel,
            attribute: .top,
            relatedBy: .equal,
            toItem: genreLabel,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 10.0)
        
        let languagesLeading = NSLayoutConstraint(
            item: languagesLabel,
            attribute: .leading,
            relatedBy: .equal,
            toItem: bottomContainerView,
            attribute: .leading,
            multiplier: 1.0,
            constant: 20.0)
        
        let languagesWidth = NSLayoutConstraint(
            item: languagesLabel,
            attribute: .width,
            relatedBy: .equal,
            toItem: bottomContainerView,
            attribute: .width,
            multiplier: 0.8,
            constant: 0.0)
        
        bottomContainerView.addConstraints([
            languagesTop,
            languagesLeading,
            languagesWidth]
        )
        
        buyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let buyTop = NSLayoutConstraint(
            item: buyLabel,
            attribute: .top,
            relatedBy: .equal,
            toItem: languagesLabel,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 20.0)
        
        let buyCenterX = NSLayoutConstraint(
            item: buyLabel,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: bottomContainerView,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
        
        let buyWidth = NSLayoutConstraint(
            item: buyLabel,
            attribute: .width,
            relatedBy: .equal,
            toItem: bottomContainerView,
            attribute: .width,
            multiplier: 0.8,
            constant: 0.0)
        
        bottomContainerView.addConstraints([
            buyTop,
            buyCenterX,
            buyWidth]
        )

        //TODO: Need to add theatres view
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let descriptionTop = NSLayoutConstraint(
            item: descriptionLabel,
            attribute: .top,
            relatedBy: .equal,
            toItem: buyLabel,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 20.0)
        
        let descriptionCenterX = NSLayoutConstraint(
            item: descriptionLabel,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: bottomContainerView,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
        
        let descriptionWidth = NSLayoutConstraint(
            item: descriptionLabel,
            attribute: .width,
            relatedBy: .equal,
            toItem: bottomContainerView,
            attribute: .width,
            multiplier: 0.8,
            constant: 0.0)
        
        bottomContainerView.addConstraints([
            descriptionTop,
            descriptionCenterX,
            descriptionWidth]
        )
        
    }
}
