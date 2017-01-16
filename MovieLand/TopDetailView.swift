//
//  TopDetailView.swift
//  MovieLand
//
//  Created by Lea Marolt on 1/15/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import UIKit

protocol TopDetailViewDelegate: class {
    func userRating(for movie: Movie, wasChanged to: Double)
}

class TopDetailView: UIView {
    
    weak var detailDelegate: TopDetailViewDelegate?
    
    fileprivate var movie: Movie
    
    // UI
    fileprivate let overallLabel = UILabel()
    fileprivate let overallRatingView: StarsView
    fileprivate let titleLabel = UILabel()
    fileprivate let factsView: MovieFactsView
    fileprivate let predictionLabel = UILabel()
    fileprivate let predictionRating = UIView()
    fileprivate let yourRating: StarsView
    
    init(with movie: Movie) {
        self.movie = movie
        self.factsView = MovieFactsView(with: movie, fontSize: 14.0)
        self.overallRatingView = StarsView(withRating: movie.rating)
        
        if let actualRating = movie.yourActualRating {
            self.yourRating = StarsView(withRating: actualRating)
        } else {
            self.yourRating = StarsView(withRating: movie.yourPredictedRating)
        }
        
        super.init(frame: .zero)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        overallLabel.text = "OVERALL: "
        titleLabel.text = movie.title
        
        var predictionText = "PREDICTED RATING: "
        if movie.yourActualRating != nil {
            predictionText = "YOUR RATING: "
        } else {
            yourRating.grayscale()
        }
        predictionLabel.text = predictionText
        
        // OVERALL:
        overallLabel.font = UIFont.brownBold(withSize: 14)
        overallLabel.textColor = UIColor.white
        overallLabel.numberOfLines = 0
        overallLabel.textAlignment = .center
        addSubview(overallLabel)
        
        // OVERALL RATING:
        overallRatingView.isUserInteractionEnabled = false
        addSubview(overallRatingView)
        
        // TITLE:
        titleLabel.font = UIFont.brownBold(withSize: 24)
        titleLabel.textColor = UIColor.white
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
        
        // MOVIE FACTS: Year, Admission Rating, Length
        addSubview(factsView)
        
        // PREDICTION:
        predictionLabel.font = UIFont.brownBold(withSize: 18)
        predictionLabel.textColor = UIColor.white
        predictionLabel.numberOfLines = 0
        addSubview(predictionLabel)
        
        // YOUR RATING:
        yourRating.ratingDelegate = self
        addSubview(yourRating)
        
        setupConstraints()
    }
}

extension TopDetailView: StarsViewDelegate {
    func ratingDidChange(to rating: Double) {
        if let delegate = detailDelegate {
            delegate.userRating(for: movie, wasChanged: rating)
            predictionLabel.text = "YOUR RATING: "
        }
    }
}

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
