//
//  QuickMovieDetailsViewController.swift
//  MovieLand
//
//  Created by Lea Marolt on 1/15/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import UIKit

protocol QuickMovieDetailsDelegate: class {
    func quickMovieDidDismiss()
    func userRating(for movie: Movie, wasChanged toRating: Double)
}

class QuickMovieDetailsViewController: UIViewController {
    
    weak var delegate: QuickMovieDetailsDelegate?
    
    fileprivate let movie: Movie
    fileprivate let point: CGPoint
    
    // UI
    fileprivate let yourRating: StarsView
    fileprivate let starsViewHeight:CGFloat = 25
    fileprivate let titleLabel = UILabel()
    fileprivate let containerView = UIView()
    fileprivate let blurView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.dark))
    
    init(with movie: Movie, touchReceivedAt point: CGPoint) {
        
        self.movie = movie
        
        if let actualRating = movie.yourActualRating {
            self.yourRating = StarsView(withRating: actualRating)
        } else {
            self.yourRating = StarsView(withRating: movie.yourPredictedRating)
        }
        
        self.point = point
        
        super.init(nibName: nil, bundle: nil)
        modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor.clear
        
        // Tap gesture recognizer for dismissal
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(close))
        view.addGestureRecognizer(tapGestureRecognizer)
        
        // Containers for stars & blur view
        view.addSubview(containerView)
        containerView.backgroundColor = UIColor.clear
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 10
        containerView.addSubview(blurView)
        
        // Ttitle
        titleLabel.text = movie.title
        titleLabel.font = UIFont.brownBold(withSize: 16)
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.white
        titleLabel.numberOfLines = 0
        view.addSubview(titleLabel)
        
        // Stars View
        if movie.yourActualRating == nil {
            yourRating.grayscale()
        }
        yourRating.ratingDelegate = self
        view.addSubview(yourRating)
        
        setupConstraints()
    }
    
    func close() {
        dismiss(animated: true) { 
            if let delegate = self.delegate {
                delegate.quickMovieDidDismiss()
            }
        }
    }
}

extension QuickMovieDetailsViewController: StarsViewDelegate {
    func ratingDidChange(to rating: Double) {
        if let delegate = delegate {
            delegate.userRating(for: movie, wasChanged: rating)
        }
    }
}

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
