//
//  MovieDetailViewController.swift
//  MovieLand
//
//  Created by Lea Marolt on 1/14/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var movieData: Movie
    
    let imageView = UIImageView()
    let closeButton = UIButton()
    
    let genreLabel = UILabel()
    let languagesLabel = UILabel()
    let buyLabel = UILabel()
    let descriptionLabel = UILabel()
    let bottomContainerView = UIView()
    
    let topContainerView = UIView()
    let overallLabel = UILabel()
    let overallRatingView = UIView()
    let titleLabel = UILabel()
    let yearLabel = UILabel()
    let admissionRatingLabel = UILabel()
    let lengthLabel = UILabel()
    let predictionLabel = UILabel()
    let predictionRating = UIView()
    let yourRating = UIView()
    
    init(with movie: Movie) {
        self.movieData = movie
        super.init(nibName: nil, bundle: nil)
        modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.cornerRadius = 50
        setupText()
        setupView()
    }
    
    //TODO: Why doesn't this go into the didSet method of the movieData
    func setupText() {
        // Top View:
        overallLabel.text = "OVERALL: "
        //TODO: Overall rating view
        titleLabel.text = movieData.title
        yearLabel.text = "\(movieData.year)"
        admissionRatingLabel.text = "\(movieData.admissionRating.rawValue)"
        lengthLabel.text = "\(movieData.length)"
        predictionLabel.text = "PREDICTION: "
        //TODO: Prediction RATING
        //TODO: your rating
        
        // Bottom View:
        genreLabel.text = "GENRES: " + movieData.genres.map { $0.rawValue }.joined(separator: ", ")
        languagesLabel.text = "LANGUAGES: " + movieData.languages.joined(separator: ", ")
        buyLabel.text = "BUY TICKETS"
        //TODO: Theatre Views
        descriptionLabel.text = movieData.description
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
        closeButton.setTitleColor(UIColor.black, for: .normal)
        //view.addSubview(closeButton)
        bottomContainerView.addSubview(closeButton)
        
        // Top Container View
        overallLabel.font = UIFont.brownBold(withSize: 14)
        overallLabel.textColor = UIColor.white
        overallLabel.numberOfLines = 0
        overallLabel.textAlignment = .center
        topContainerView.addSubview(overallLabel)
        
        topContainerView.addSubview(overallRatingView)
        
        titleLabel.font = UIFont.brownBold(withSize: 24)
        titleLabel.textColor = UIColor.white
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        topContainerView.addSubview(titleLabel)
        
        yearLabel.font = UIFont.brownBold(withSize: 12)
        yearLabel.textColor = UIColor.white
        yearLabel.numberOfLines = 0
        topContainerView.addSubview(yearLabel)
        
        admissionRatingLabel.font = UIFont.brownBold(withSize: 12)
        admissionRatingLabel.layer.borderColor = UIColor.white.cgColor
        admissionRatingLabel.layer.borderWidth = 2
        admissionRatingLabel.textColor = UIColor.white
        admissionRatingLabel.numberOfLines = 0
        topContainerView.addSubview(admissionRatingLabel)
        
        lengthLabel.font = UIFont.brownBold(withSize: 12)
        lengthLabel.textColor = UIColor.white
        lengthLabel.numberOfLines = 0
        topContainerView.addSubview(lengthLabel)
        
        predictionLabel.font = UIFont.brownBold(withSize: 14)
        predictionLabel.textColor = UIColor.white
        predictionLabel.numberOfLines = 0
        topContainerView.addSubview(predictionLabel)
        
        view.addSubview(topContainerView)
        
        // Bottom Container View
        genreLabel.font = UIFont.brownBold(withSize: 14)
        genreLabel.textColor = UIColor.black
        genreLabel.numberOfLines = 0
        bottomContainerView.addSubview(genreLabel)
        
        languagesLabel.font = UIFont.brownBold(withSize: 14)
        languagesLabel.textColor = UIColor.black
        languagesLabel.numberOfLines = 0
        bottomContainerView.addSubview(languagesLabel)
        
        buyLabel.font = UIFont.brownBold(withSize: 18)
        buyLabel.textColor = UIColor.black
        buyLabel.textAlignment = .center
        bottomContainerView.addSubview(buyLabel)
    
        //TODO: Add theatre views here!
        
        descriptionLabel.font = UIFont.brown(withSize: 12)
        descriptionLabel.textColor = UIColor.black
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        bottomContainerView.addSubview(descriptionLabel)
        
        bottomContainerView.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        view.addSubview(bottomContainerView)
        
        setupConstraints()
    }
    
    func close() {
        dismiss(animated: true, completion: nil)
    }
}
