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
    let point: CGPoint
    
    // UI
    let yourRating: StarsView
    let starsViewHeight:CGFloat = 25
    let titleLabel = UILabel()
    let containerView = UIView()
    let blurView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.dark))
    
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
