//
//  StarsView.swift
//  MovieLand
//
//  Created by Lea Marolt on 1/15/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import UIKit

enum StarType: String {
    case Full
    case Half
    case Empty
    
    func image() -> UIImage {
        switch self {
        case .Full:
            return UIImage(named: "FullStar")!
        case .Half:
            return UIImage(named: "HalfStar")!
        case .Empty:
            return UIImage(named: "EmptyStar")!
        }
    }
}

class StarsImageView: UIImageView {
    
    var type: StarType
    
    var greyScaleImage: UIImage {
        return type.image().grayscaleImage()
    }
    
    var coloredImage: UIImage {
        return type.image()
    }
    
    init(with type: StarType) {
        self.type = type
        super.init(image: type.image())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateStars(animated: Bool) {
        if animated {
            self.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            
            UIView.animate(withDuration: 0.20, animations: {
                self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }, completion: { (finished) in
                UIView.animate(withDuration: 0.1, animations: {
                    self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                }, completion: { (finished) in
                    self.transform = CGAffineTransform.identity
                })
            })
        }
    }
}

protocol StarsViewDelegate: class {
    func ratingDidChange(to rating: Double)
}

class StarsView: UIView {
    
    weak var ratingDelegate: StarsViewDelegate?
    
    // Round float to nearest 0.5
    let rating: Double
    
    // UI
    let starsView = UIView()
    let fullStarImage = UIImage(named: "FullStar")
    let emptyStarImage = UIImage(named: "EmptyStar")
    let halfStarImage = UIImage(named: "HalfStar")
    var allStars: [StarsImageView] = []
    
    init(withRating rating: Double) {
        self.rating = rating
        super.init(frame: .zero)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func grayscale() {
        for star in allStars {
            star.image = star.greyScaleImage
        }
    }
    
    func colorize(with newRating: Double, animated: Bool) {
        
        updateTypes(for: newRating)
        
        for star in allStars {
            star.updateStars(animated: animated)
            star.image = star.coloredImage
        }
    }
    
    @objc private func tapped(with gestureRecognizer: UITapGestureRecognizer) {
        let pointTapped = gestureRecognizer.location(in: self)
        
        for star in allStars {
            if star.frame.contains(pointTapped) {
                let index = allStars.index(of: star)!
                colorize(with: Double(index+1), animated: true)
            }
        }
    }
    
    @objc private func panned(with gestureRecognizer: UIPanGestureRecognizer) {

        if gestureRecognizer.state == UIGestureRecognizerState.ended {
            let endTapLocation = gestureRecognizer.location(in: self)
            for star in allStars {
                if star.frame.contains(endTapLocation) {
                    let index = allStars.index(of: star)!
                    colorize(with: Double(index+1), animated: true)
                }
            }
        }
    }
    
    private func setupViews() {
        
        // Add tap gesture recognizer for rating
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped(with:)))
        addGestureRecognizer(tapGestureRecognizer)
        
        // Add pan gesture recognizer for rating
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panned(with:)))
        addGestureRecognizer(panGestureRecognizer)
        
        // Create & Add all views
        for _ in 0...4 {
            let starImageView = StarsImageView(with: .Empty)
            addSubview(starImageView)
            
            starImageView.translatesAutoresizingMaskIntoConstraints = false
            allStars.append(starImageView)
        }

        setupConstraints()
        
        colorize(with: rating, animated: false)
    }
    
    private func updateTypes(for currentRating: Double) {
        // Update the ratings
        // Add 5 stars
        let fullStars = Int(floor(currentRating))
        let emptyStars = Int(5 - ceil(currentRating))
        let halfStars = (5.0 - Double(fullStars) - Double(emptyStars) > 0.5) ? 1 : 0 // There can only ever be 1 half star
        
        for i in 0...fullStars-1 {
            allStars[i].type = .Full
        }
        
        if halfStars == 1 {
            allStars[fullStars-1].type = .Half
        }
        
        if fullStars < emptyStars+fullStars {
            for i in fullStars...emptyStars+fullStars-1 {
                allStars[i].type = .Empty
            }
        }
        
        if let delegate = ratingDelegate {
            delegate.ratingDidChange(to: currentRating)
        }
    }
}

extension StarsView {
    func setupConstraints() {
        for i in 0...allStars.count-1 {
            
            let starImageView = allStars[i]
            starImageView.contentMode = .scaleAspectFit
            
            let starTop = NSLayoutConstraint(
                item: starImageView,
                attribute: .top,
                relatedBy: .equal,
                toItem: self,
                attribute: .top,
                multiplier: 1.0,
                constant: 0.0)
            
            let starBottom = NSLayoutConstraint(
                item: starImageView,
                attribute: .bottom,
                relatedBy: .equal,
                toItem: self,
                attribute: .bottom,
                multiplier: 1.0,
                constant: 0.0)
            
            var starLeading: NSLayoutConstraint
            
            if i == 0 {
                starLeading = NSLayoutConstraint(
                    item: starImageView,
                    attribute: .leading,
                    relatedBy: .equal,
                    toItem: self,
                    attribute: .leading,
                    multiplier: 1.0,
                    constant: 0.0)
            } else {
                let starViewBefore = allStars[i-1]
                starLeading = NSLayoutConstraint(
                    item: starImageView,
                    attribute: .leading,
                    relatedBy: .equal,
                    toItem: starViewBefore,
                    attribute: .trailing,
                    multiplier: 1.0,
                    constant: 10)
            }
            
            let starHeight = NSLayoutConstraint(
                item: starImageView,
                attribute: .height,
                relatedBy: .equal,
                toItem: starImageView,
                attribute: .width,
                multiplier: 1.0,
                constant: 0.0)
            
            addConstraints([
                starTop,
                starBottom,
                starLeading,
                starHeight]
            )
        }
        
        let viewTrailing = NSLayoutConstraint(
            item: self,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: allStars[4],
            attribute: .trailing,
            multiplier: 1.0,
            constant: 0.0)
        
        addConstraints([
            viewTrailing]
        )
    }
}
