//
//  BottomDetailView.swift
//  MovieLand
//
//  Created by Lea Marolt on 1/15/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import UIKit
import CoreLocation

protocol BottomDetailDelegate: class {
    func didTap(on theatre: TheatreView)
}

class BottomDetailView: UIView {
    
    weak var delegate: BottomDetailDelegate?
    var locationManager: CLLocationManager
    
    // Data
    private let movie: Movie
    var locationEnabled: Bool {
        didSet {
            updateTheatreView(with: locationEnabled)
        }
    }
    
    // UI
    let scrollContainerView = UIScrollView()
    let contentView = UIView()
    let genreLabel = UILabel()
    let languagesLabel = UILabel()
    let buyLabel = UILabel()
    let theatreView = UIView()
    let descriptionLabel = UILabel()
    
    init(with movie: Movie) {
        self.movie = movie
        self.locationManager = CLLocationManager()
        self.locationEnabled = CLLocationManager.authorizationStatus() == .authorizedWhenInUse
        super.init(frame: .zero)
        
        self.locationManager.delegate = self
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupData() {
        // Bottom View:
        buyLabel.text = "BUY TICKETS"
        //TODO: Theatre Views
        descriptionLabel.text = movie.description
    }
    
    func updateTheatreView(with locationEnabled: Bool) {
        setupTheatreView(with: locationEnabled)
        setupConstraints()
    }
    
    private func setupViews() {
        setupData()
        
        // GENRES: ...
        let genre = "GENRE: "
        let genreRange = NSRange.init(location: 0, length: genre.characters.count)
        let genreText = NSMutableAttributedString(string: genre)
        genreText.addAttributes(
            [NSFontAttributeName : UIFont.brownBold(withSize: 14)],
            range: genreRange)
        
        let genreDetails = movie.genres.map { $0.rawValue }.joined(separator: ", ")
        let genreDetailsRange = NSRange.init(location: 0, length: genreDetails.characters.count)
        let genreDetailsText = NSMutableAttributedString(string: genreDetails)
        genreDetailsText.addAttributes(
            [NSFontAttributeName : UIFont.brown(withSize: 14)],
            range: genreDetailsRange)
        
        let genreAttributedString: NSMutableAttributedString = genreText
        genreAttributedString.append(genreDetailsText)
        genreLabel.attributedText = genreAttributedString
        genreLabel.textColor = UIColor.black
        genreLabel.numberOfLines = 0
        addSubview(genreLabel)
        
        // LANGUAGES: ...
        let language = "LANGUAGES: "
        let languageRange = NSRange.init(location: 0, length: language.characters.count)
        let languageText = NSMutableAttributedString(string: language)
        languageText.addAttributes(
            [NSFontAttributeName : UIFont.brownBold(withSize: 14)],
            range: languageRange)
        
        let languageDetails = movie.languages.joined(separator: ", ")
        let languageDetailsRange = NSRange.init(location: 0, length: languageDetails.characters.count)
        let languageDetailsText = NSMutableAttributedString(string: languageDetails)
        languageDetailsText.addAttributes(
            [NSFontAttributeName : UIFont.brown(withSize: 14)],
            range: languageDetailsRange)
        
        let languageAttributedString: NSMutableAttributedString = languageText
        languageAttributedString.append(languageDetailsText)
        languagesLabel.attributedText = languageAttributedString
        languagesLabel.textColor = UIColor.black
        languagesLabel.numberOfLines = 0
        addSubview(languagesLabel)
        
        // BUY TICKETS
        buyLabel.font = UIFont.brownBold(withSize: 18)
        buyLabel.textColor = UIColor.black
        buyLabel.textAlignment = .center
        addSubview(buyLabel)
        
        // THEATRE VIEW
        setupTheatreView(with: locationEnabled)
        addSubview(theatreView)
        
        // DESCRIPTION
        descriptionLabel.font = UIFont.brown(withSize: 12)
        descriptionLabel.textColor = UIColor.black
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        addSubview(descriptionLabel)
        
        backgroundColor = UIColor.white.withAlphaComponent(0.7)
        
        setupConstraints()
    }
}

extension BottomDetailView: TheatreViewDelegate {
    func didTapOnTheatre(theatre: TheatreView) {
        guard let delegate = delegate else { return }
        delegate.didTap(on: theatre)
    }
}

extension BottomDetailView: CLLocationManagerDelegate {
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        locationEnabled = status == .authorizedWhenInUse
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    }
}

