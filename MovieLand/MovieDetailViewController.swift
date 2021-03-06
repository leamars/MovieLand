//
//  MovieDetailViewController.swift
//  MovieLand
//
//  Created by Lea Marolt on 1/14/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import UIKit
import CoreLocation

protocol MovieDetailsDelegate: class {
    func movie(updated movie: Movie, with rating: Double)
}

class MovieDetailViewController: UIViewController {
    
    weak var delegate: MovieDetailsDelegate?
    let locationManager = CLLocationManager()
    
    // Data
    var movie: Movie
    
    // UI
    let imageView = UIImageView()
    let topDetailView: TopDetailView
    let bottomDetailView: BottomDetailView
    
    init(with movie: Movie) {
        
        self.movie = movie
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
        locationManager.requestWhenInUseAuthorization()
        setupView()
    }
    
    private func setupView() {
        
        setupGestures()
        
        // Image View
        imageView.image = movie.image
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        
        // Top Detail View
        topDetailView.detailDelegate = self
        view.addSubview(topDetailView)
        
        // Bottom Detail View
        bottomDetailView.delegate = self
        view.addSubview(bottomDetailView)
        
        setupConstraints()
    }
    
    private func setupGestures() {
        
        // Swipe down recognizer
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(close))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        view.addGestureRecognizer(swipeDown)
    }
    
    @objc private func close() {
        
        modalTransitionStyle = .coverVertical
        dismiss(animated: true, completion: nil)
    }
}

extension MovieDetailViewController: TopDetailViewDelegate {
    func userRating(for movie: Movie, wasChanged to: Double) {
        guard let delegate = delegate else { return }
        delegate.movie(updated: movie, with: to)
    }
}

extension MovieDetailViewController: BottomDetailDelegate {
    func didTap(on theatre: TheatreView) {
        
        // Show alert to buy ticket
        let alertController = UIAlertController(title: "Ahoy Movie Buff!", message:
            "So, you're trying to see \(movie.title) at the wonderful \(theatre.title) theatre?", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Buy Ticket", style: UIAlertActionStyle.default, handler: nil))
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
}


