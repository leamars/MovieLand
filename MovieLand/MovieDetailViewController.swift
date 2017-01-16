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
    
    var movie: Movie
    
    let imageView = UIImageView()
    
    let topDetailView: TopDetailView
    let bottomDetailView: BottomDetailView
    
    let locationManager = LocationManager()
    
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
        view.layer.cornerRadius = 50
        setupView()
    }
    
    func setupView() {
        
        // Image View
        imageView.image = movie.image
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
                
        topDetailView.detailDelegate = self
        view.addSubview(topDetailView)
        
        bottomDetailView.delegate = self
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
        guard let delegate = delegate else { return }
        delegate.movie(updated: movie, with: to)
    }
}

extension MovieDetailViewController: BottomDetailDelegate {
    func didTap(on theatre: TheatreView) {
        // Show Alert for ticket booked
        let alertController = UIAlertController(title: "Ahoy Movie Buff!", message:
            "So, you're trying to see \(movie.title) at the wonderful \(theatre.title)?", preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "Buy Ticket", style: UIAlertActionStyle.default, handler: nil))
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
}



