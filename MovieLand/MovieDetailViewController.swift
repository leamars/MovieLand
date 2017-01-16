//
//  MovieDetailViewController.swift
//  MovieLand
//
//  Created by Lea Marolt on 1/14/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import UIKit

protocol MovieDetailsDelegate: class {
    func movie(updated movie: Movie, with rating: Double)
}

class MovieDetailViewController: UIViewController {
    
    weak var delegate: MovieDetailsDelegate?
    
    var movieData: Movie
    
    let imageView = UIImageView()
    let closeButton = UIButton()
    
    let topDetailView: TopDetailView
    let bottomDetailView: BottomDetailView
    
    init(with movie: Movie) {
        
        self.movieData = movie
        self.topDetailView = TopDetailView(with: movie)
        self.bottomDetailView = BottomDetailView(with: movie)
        
        super.init(nibName: nil, bundle: nil)
        modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.cornerRadius = 50
        setupView()
    }
    
    func setupView() {
        
        // Image View
        imageView.image = movieData.image
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        
        // Close Button
        closeButton.addTarget(self, action: #selector(MovieDetailViewController.close), for: .touchUpInside)
        closeButton.setTitle("CLOSE", for: .normal)
        closeButton.setTitle("CLOSE", for: .highlighted)
        closeButton.setTitle("CLOSE", for: .selected)
        closeButton.setTitleColor(UIColor.clear, for: .normal)
        //view.addSubview(closeButton)
        bottomDetailView.addSubview(closeButton)
        
        topDetailView.detailDelegate = self
        view.addSubview(topDetailView)
        view.addSubview(bottomDetailView)
        
        // Swipe down recognizer
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(close))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        view.addGestureRecognizer(swipeDown)
        
        setupConstraints()
    }
    
    func close() {
        modalTransitionStyle = .coverVertical
        dismiss(animated: true, completion: nil)
    }
}

extension MovieDetailViewController: TopDetailViewDelegate {
    func userRating(for movie: Movie, wasChanged to: Double) {
        if let delegate = delegate {
            delegate.movie(updated: movie, with: to)
        }
    }
}

