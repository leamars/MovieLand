//
//  FiltersViewLayout.swift
//  MovieLand
//
//  Created by Lea Marolt on 1/14/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import UIKit

extension FiltersView {
    func setupConstraints() {
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        
        let underlineHeight = NSLayoutConstraint(
            item: underlineView,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: tableTopOffset)
        
        let underlineCenterX = NSLayoutConstraint(
            item: underlineView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
        
        let underlineWidth = NSLayoutConstraint(
            item: underlineView,
            attribute: .width,
            relatedBy: .equal,
            toItem: self,
            attribute: .width,
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
        
        addConstraints([
            underlineHeight,
            underlineWidth,
            underlineBottom,
            underlineCenterX]
        )
        
        genresLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Let's not anchor this to the searchbar
        
        let genresLeft = NSLayoutConstraint(
            item: genresLabel,
            attribute: .left,
            relatedBy: .equal,
            toItem: self,
            attribute: .left,
            multiplier: 1.0,
            constant: 20.0)
        
        let genresTop = NSLayoutConstraint(
            item: genresLabel,
            attribute: .top,
            relatedBy: .equal,
            toItem: self,
            attribute: .top,
            multiplier: 1.0,
            constant: 70.0)
        
        addConstraints([
            genresLeft,
            genresTop]
        )
        
        genreCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let genresCollectionWidth = NSLayoutConstraint(
            item: genreCollectionView,
            attribute: .width,
            relatedBy: .equal,
            toItem: self,
            attribute: .width,
            multiplier: 1,
            constant: 0)
        
        let genresCollectionX = NSLayoutConstraint(
            item: genreCollectionView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
        
        let genresCollectionTop = NSLayoutConstraint(
            item: genreCollectionView,
            attribute: .top,
            relatedBy: .equal,
            toItem: genresLabel,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 10.0)
        
        let genresCollectionHeight = NSLayoutConstraint(
            item: genreCollectionView,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: 30)
        
        addConstraints([
            genresCollectionWidth,
            genresCollectionX,
            genresCollectionTop,
            genresCollectionHeight]
        )
        
        selectedGenreCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let selectedGenresCollectionWidth = NSLayoutConstraint(
            item: selectedGenreCollectionView,
            attribute: .width,
            relatedBy: .equal,
            toItem: genreCollectionView,
            attribute: .width,
            multiplier: 1,
            constant: 0)
        
        let selectedGenresCollectionX = NSLayoutConstraint(
            item: selectedGenreCollectionView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: genreCollectionView,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
        
        let selectedGenresCollectionTop = NSLayoutConstraint(
            item: selectedGenreCollectionView,
            attribute: .top,
            relatedBy: .equal,
            toItem: genreCollectionView,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 5.0)
        
        let selectedGenresCollectionHeight = NSLayoutConstraint(
            item: selectedGenreCollectionView,
            attribute: .height,
            relatedBy: .equal,
            toItem: genreCollectionView,
            attribute: .height,
            multiplier: 1.0,
            constant: 0.0)
        
        addConstraints([
            selectedGenresCollectionWidth,
            selectedGenresCollectionX,
            selectedGenresCollectionTop,
            selectedGenresCollectionHeight]
        )
    }
}
