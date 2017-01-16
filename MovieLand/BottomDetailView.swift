//
//  BottomDetailView.swift
//  MovieLand
//
//  Created by Lea Marolt on 1/15/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import UIKit

protocol BottomDetailDelegate: class {
    func didTap(on theatre: TheatreView)
}

class BottomDetailView: UIView {
    
    weak var delegate: BottomDetailDelegate?
    
    // Data
    private let movie: Movie
    
    // UI
    private let scrollContainerView = UIScrollView()
    private let contentView = UIView()
    private let genreLabel = UILabel()
    private let languagesLabel = UILabel()
    private let buyLabel = UILabel()
    private let theatreView = UIView()
    private let descriptionLabel = UILabel()
    
    init(with movie: Movie) {
        self.movie = movie
        super.init(frame: .zero)
        
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
        setupTheatreView()
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
    
    private func setupTheatreView() {
        
        theatreView.translatesAutoresizingMaskIntoConstraints = false
        
        let amcTheatre = TheatreView(with: "AMC Loews", distance: 0.8, imageName: "amcTheatre")
        amcTheatre.delegate = self
        theatreView.addSubview(amcTheatre)
        
        let villageTheatre = TheatreView(with: "Village East", distance: 1.4, imageName: "villageTheatre")
        villageTheatre.delegate = self
        theatreView.addSubview(villageTheatre)
        
        let lincolnTheatre = TheatreView(with: "Lincoln Plaza", distance: 5.7, imageName: "lincolnTheatre")
        lincolnTheatre.delegate = self
        theatreView.addSubview(lincolnTheatre)
        
        villageTheatre.translatesAutoresizingMaskIntoConstraints = false
        
        let villageTop = NSLayoutConstraint(
            item: villageTheatre,
            attribute: .top,
            relatedBy: .equal,
            toItem: theatreView,
            attribute: .top,
            multiplier: 1.0,
            constant: 0.0)
        
        let villageCenterX = NSLayoutConstraint(
            item: villageTheatre,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: theatreView,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
        
        let villageBottom = NSLayoutConstraint(
            item: amcTheatre,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: theatreView,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 0.0)
        
        theatreView.addConstraints([
            villageTop,
            villageCenterX,
            villageBottom]
        )
        
        amcTheatre.translatesAutoresizingMaskIntoConstraints = false
        
        let amcTop = NSLayoutConstraint(
            item: amcTheatre,
            attribute: .top,
            relatedBy: .equal,
            toItem: theatreView,
            attribute: .top,
            multiplier: 1.0,
            constant: 0.0)
        
        let amcLeading = NSLayoutConstraint(
            item: amcTheatre,
            attribute: .leading,
            relatedBy: .equal,
            toItem: theatreView,
            attribute: .leading,
            multiplier: 1.0,
            constant: 0.0)
        
        let amcBottom = NSLayoutConstraint(
            item: amcTheatre,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: theatreView,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 0.0)
        
        theatreView.addConstraints([
            amcTop,
            amcLeading,
            amcBottom]
        )
        
        lincolnTheatre.translatesAutoresizingMaskIntoConstraints = false
        
        let lincolnTop = NSLayoutConstraint(
            item: lincolnTheatre,
            attribute: .top,
            relatedBy: .equal,
            toItem: theatreView,
            attribute: .top,
            multiplier: 1.0,
            constant: 0.0)
        
        let lincolnTrailing = NSLayoutConstraint(
            item: lincolnTheatre,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: theatreView,
            attribute: .trailing,
            multiplier: 1.0,
            constant: 0.0)
        
        let lincolnBottom = NSLayoutConstraint(
            item: lincolnTheatre,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: theatreView,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 0.0)
        
        theatreView.addConstraints([
            lincolnTop,
            lincolnTrailing,
            lincolnBottom]
        )
        
    }
    
    private func setupConstraints() {
                
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let genreTop = NSLayoutConstraint(
            item: genreLabel,
            attribute: .top,
            relatedBy: .equal,
            toItem: self,
            attribute: .top,
            multiplier: 1.0,
            constant: 20.0)
        
        let genreLeading = NSLayoutConstraint(
            item: genreLabel,
            attribute: .leading,
            relatedBy: .equal,
            toItem: self,
            attribute: .leading,
            multiplier: 1.0,
            constant: 20.0)
        
        let genreWidth = NSLayoutConstraint(
            item: genreLabel,
            attribute: .width,
            relatedBy: .equal,
            toItem: self,
            attribute: .width,
            multiplier: 0.9,
            constant: 0.0)
        
        addConstraints([
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
            toItem: self,
            attribute: .leading,
            multiplier: 1.0,
            constant: 20.0)
        
        let languagesWidth = NSLayoutConstraint(
            item: languagesLabel,
            attribute: .width,
            relatedBy: .equal,
            toItem: self,
            attribute: .width,
            multiplier: 0.9,
            constant: 0.0)
        
        addConstraints([
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
            toItem: self,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
        
        let buyWidth = NSLayoutConstraint(
            item: buyLabel,
            attribute: .width,
            relatedBy: .equal,
            toItem: self,
            attribute: .width,
            multiplier: 0.8,
            constant: 0.0)
        
        addConstraints([
            buyTop,
            buyCenterX,
            buyWidth]
        )
        
        let theatreTop = NSLayoutConstraint(
            item: theatreView,
            attribute: .top,
            relatedBy: .equal,
            toItem: buyLabel,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 20.0)
        
        let theatreCenterX = NSLayoutConstraint(
            item: theatreView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
        
        let theatreWidth = NSLayoutConstraint(
            item: theatreView,
            attribute: .width,
            relatedBy: .equal,
            toItem: self,
            attribute: .width,
            multiplier: 0.9,
            constant: 0.0)
        
        addConstraints([
            theatreTop,
            theatreCenterX,
            theatreWidth]
        )
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let descriptionTop = NSLayoutConstraint(
            item: descriptionLabel,
            attribute: .top,
            relatedBy: .equal,
            toItem: theatreView,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 20.0)
        
        let descriptionCenterX = NSLayoutConstraint(
            item: descriptionLabel,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
        
        let descriptionWidth = NSLayoutConstraint(
            item: descriptionLabel,
            attribute: .width,
            relatedBy: .equal,
            toItem: self,
            attribute: .width,
            multiplier: 0.95,
            constant: 0.0)
        
        addConstraints([
            descriptionTop,
            descriptionCenterX,
            descriptionWidth]
        )

    }
}

extension BottomDetailView: TheatreViewDelegate {
    func didTapOnTheatre(theatre: TheatreView) {
        guard let delegate = delegate else { return }
        delegate.didTap(on: theatre)
    }
}
