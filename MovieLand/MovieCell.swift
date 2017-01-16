//
//  MovieCell.swift
//  MovieLand
//
//  Created by Lea Marolt on 1/7/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import UIKit

protocol MovieCellDelegate: class {
    func forceTouchReceived(in movieCell: MovieCell, at point: CGPoint)
}

class MovieCell: UICollectionViewCell {
    
    static let identifier = "MovieCell"
    
    weak var forceTouchDelegate: MovieCellDelegate?
    
    // UI
    let imageView = UIImageView()
    let containerView = UIView()
    var titleLabel = UILabel()
    
    // Data
    var movie: Movie? {
        didSet {
            titleLabel.text = movie?.title
            imageView.image = movie?.image
        }
    }
    
    //MARK: Init & Deinit
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: CollectionViewCell
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    //MARK: Touches
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if #available(iOS 9.0, *) {
                if traitCollection.forceTouchCapability == UIForceTouchCapability.available {
                    // 3D Touch capable
                    let pointOnCell = touch.location(in: contentView)
                    if let pointInScreen = touch.view?.convert(pointOnCell, to: nil) {
                        quickViewOpen(at: pointInScreen)
                    }
                }
            }
        }
    }
    
    @objc private func didLongPress(with gestureRecognizer: UILongPressGestureRecognizer) {
        let pointOnCell = gestureRecognizer.location(in: contentView)
        if let pointInScreen = gestureRecognizer.view?.convert(pointOnCell, to: nil) {
            quickViewOpen(at: pointInScreen)
        }
    }
    
    private func quickViewOpen(at point: CGPoint) {
        if let delegate = forceTouchDelegate {
            delegate.forceTouchReceived(in: self, at: point)
        }
    }
    
    //MARK: Private
    private func setupViews() {

        contentView.addSubview(containerView)
        
        // Image view setup
        containerView.addSubview(imageView)
        
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.masksToBounds = false
        imageView.layer.shadowOffset = CGSize(width: -5, height: 5)
        imageView.layer.shadowRadius = 5
        imageView.layer.shadowOpacity = 0.5

        containerView.clipsToBounds = false
        
        // Title label setup
        contentView.addSubview(titleLabel)
        titleLabel.numberOfLines = 3
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.brown(withSize: 14)
        
        // Long Press gesture recognizer
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(didLongPress(with:)))
        containerView.addGestureRecognizer(longPressRecognizer)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        let contentWidth = NSLayoutConstraint(item: containerView, attribute: .width, relatedBy: .equal, toItem: contentView, attribute: .width, multiplier: 1, constant: 0.0)
        let contentX = NSLayoutConstraint(item: containerView, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let contentTop = NSLayoutConstraint(item: containerView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 5.0)
        let contentHeight = NSLayoutConstraint(item: containerView, attribute: .height, relatedBy: .equal, toItem: contentView, attribute: .height, multiplier: 0.8, constant: 0.0)
        
        contentView.addConstraints([
            contentX,
            contentTop,
            contentHeight,
            contentWidth]
        )
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        let imageWidth = NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: containerView, attribute: .width, multiplier: 1.0, constant: 0.0)
        let imageX = NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: containerView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let imageY = NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: containerView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let imageHeight = NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: containerView, attribute: .height, multiplier: 1.0, constant: 0.0)
        
        containerView.addConstraints([
            imageWidth,
            imageX,
            imageY,
            imageHeight]
        )
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let titleWidth = NSLayoutConstraint(item: titleLabel, attribute: .width, relatedBy: .equal, toItem: contentView, attribute: .width, multiplier: 0.9, constant: 0.0)
        let titleX = NSLayoutConstraint(item: titleLabel, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let titleBottom = NSLayoutConstraint(item: titleLabel, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let titleTop = NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1.0, constant: 10.0)
        
        contentView.addConstraints([
            titleWidth,
            titleX,
            titleBottom,
            titleTop]
        )
    }
    
}
