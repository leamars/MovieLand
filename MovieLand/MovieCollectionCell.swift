//
//  MovieCollectionCell.swift
//  MovieLand
//
//  Created by Lea Marolt on 1/7/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import UIKit

protocol MovieCollectionCellDelegate: class {
    func movieCellWasTapped(movieCell: MovieCell)
}

class MovieCollectionCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    static let identifier = "MovieCollectionCell"
    
    weak var movieCollectionCellDelegate: MovieCollectionCellDelegate?
    
    var collectionData: [Movie] {
        didSet {
            movieCollectionView.reloadData()
        }
    }
    
    var collectionName: String {
        didSet {
            titleLabel.text = collectionName
        }
    }
    
    let titleLabel = UILabel()
    let titleUnderlineView = UIView()
    let containerView = UIView()
    let movieCollectionView: UICollectionView
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        let flowLayout                     = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing      = 0
        flowLayout.scrollDirection         = .horizontal
        movieCollectionView                = UICollectionView(frame: CGRect.zero, collectionViewLayout:flowLayout)
        
        self.collectionName = "Collection"
        self.collectionData = []
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Default Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    //MARK: Collection View Data Source:
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return collectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier = MovieCell.identifier
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? MovieCell {
            cell.movie = collectionData[indexPath.section]
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    //MARK: Collection View Delegate:
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? MovieCell,
            let delegate = movieCollectionCellDelegate else {
            return
        }
        
        delegate.movieCellWasTapped(movieCell: cell)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
    
    //MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 140, height: 230)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsetsMake(0, 5, 0, 5)
    }
    
    //MARK: Setup
    
    private func setupViews() {
        
        contentView.addSubview(containerView)
        selectionStyle = .none
        
        // Title Label
        containerView.addSubview(titleLabel)
        titleLabel.text          = "RECOMMENDED"
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.brownBold(withSize: 22)
        
        // Title Underling
        containerView.addSubview(titleUnderlineView)
        titleUnderlineView.backgroundColor = UIColor.yellow
        
        // Movie Collection View
        containerView.addSubview(movieCollectionView)
        movieCollectionView.dataSource = self
        movieCollectionView.delegate   = self
        movieCollectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.identifier)
        movieCollectionView.backgroundColor = UIColor.clear
        movieCollectionView.showsHorizontalScrollIndicator = false
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let contentWidth = NSLayoutConstraint(
            item: containerView,
            attribute: .width,
            relatedBy: .equal,
            toItem: contentView,
            attribute: .width,
            multiplier: 1.0,
            constant: 0.0)
        
        let contentX = NSLayoutConstraint(
            item: containerView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: contentView,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
        
        let contentY = NSLayoutConstraint(
            item: containerView,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: contentView,
            attribute: .centerY,
            multiplier: 1.0,
            constant: 0.0)
        
        let contentHeight = NSLayoutConstraint(
            item: containerView,
            attribute: .height,
            relatedBy: .equal,
            toItem: contentView,
            attribute: .height,
            multiplier: 1.0,
            constant: 0.0)
        
        contentView.addConstraints([
            contentX,
            contentY,
            contentHeight,
            contentWidth]
        )
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLeft = NSLayoutConstraint(
            item: titleLabel,
            attribute: .left,
            relatedBy: .equal,
            toItem: containerView,
            attribute: .left,
            multiplier: 1.0,
            constant: 10.0)
        
        let titleTop = NSLayoutConstraint(
            item: titleLabel,
            attribute: .top,
            relatedBy: .equal,
            toItem: containerView,
            attribute: .top,
            multiplier: 1.0,
            constant: 20.0)
        
        containerView.addConstraints([
            titleLeft,
            titleTop,
            ]
        )
        
        titleUnderlineView.translatesAutoresizingMaskIntoConstraints = false
        
        let underlineTop = NSLayoutConstraint(
            item: titleUnderlineView,
            attribute: .top,
            relatedBy: .equal,
            toItem: titleLabel,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 3.0)
        
        let underlineHeight = NSLayoutConstraint(
            item: titleUnderlineView,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: 3.0)
        
        let underlineCenterX = NSLayoutConstraint(
            item: titleUnderlineView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: titleLabel,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
        
        let underlineWidth = NSLayoutConstraint(
            item: titleUnderlineView,
            attribute: .width,
            relatedBy: .equal,
            toItem: titleLabel,
            attribute: .width,
            multiplier: 1.0,
            constant: 5.0)
        
        contentView.addConstraints([
            underlineTop,
            underlineWidth,
            underlineHeight,
            underlineCenterX]
        )
        
        movieCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let movieContentWidth = NSLayoutConstraint(
            item: movieCollectionView,
            attribute: .width,
            relatedBy: .equal,
            toItem: contentView,
            attribute: .width,
            multiplier: 1.0,
            constant: 0)
        
        let movieContentX = NSLayoutConstraint(
            item: movieCollectionView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: contentView,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
        
        let movieContentTop = NSLayoutConstraint(
            item: movieCollectionView,
            attribute: .top,
            relatedBy: .equal,
            toItem: titleUnderlineView,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 5.0)
        
        let movieContentBottom = NSLayoutConstraint(
            item: movieCollectionView,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: contentView,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 0)
        
        contentView.addConstraints([
            movieContentX,
            movieContentTop,
            movieContentBottom,
            movieContentWidth]
        )
    }
}
