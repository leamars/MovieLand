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
    func forceTouchReceived(for movieCell: MovieCell, at point: CGPoint)
}

class MovieCollectionCell: UITableViewCell {
    
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
}

extension MovieCollectionCell: MovieCellDelegate {
    
    func forceTouchReceived(in movieCell: MovieCell, at point: CGPoint) {
        if let delegate = movieCollectionCellDelegate {
            delegate.forceTouchReceived(for: movieCell, at: point)
        }
    }
}

extension MovieCollectionCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
            cell.forceTouchDelegate = self
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
}
