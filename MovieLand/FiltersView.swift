//
//  FiltersView.swift
//  MovieLand
//
//  Created by Lea Marolt on 1/11/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import UIKit

protocol FiltersViewDelegate: class {
    func searchControllerDidChange(with searchQuery: String?)
    func filtersDidSelect(new genre: Genre)
    func filtersDidDeselect(new genre: Genre)
}

class FiltersView: UIView, UISearchResultsUpdating, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    weak var filtersViewDelegate: FiltersViewDelegate?
    
    //TODO: Should sort alphabetically - so that genres stay in the same place all the time
    // We should at least sort the deselected one - selected one should work as user selectes
    let allFilters: [GenreFilter] = Filters.genres()
    var allSelected: [GenreFilter] = []
    var allDeselected: [GenreFilter] = []
    
    enum FilterSection: Int {
        case Deselected
        case Selected
        static var count: Int { return FilterSection.Selected.hashValue + 1}
    }
    
    // Search Controller
    let searchController: UISearchController = UISearchController(searchResultsController: nil)
    
    // Genres
    let genresLabel:UILabel = UILabel()
    let genreCollectionView: UICollectionView
    let selectedGenreCollectionView: UICollectionView
    
    override init(frame: CGRect) {
        
        let flowLayout                     = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing      = 0
        flowLayout.scrollDirection         = .horizontal
        genreCollectionView                = UICollectionView(frame: CGRect.zero, collectionViewLayout:flowLayout)
        
        let flowLayout2                     = UICollectionViewFlowLayout()
        flowLayout2.minimumInteritemSpacing = 0
        flowLayout2.minimumLineSpacing      = 0
        flowLayout2.scrollDirection         = .horizontal
        
        selectedGenreCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout:flowLayout2)
        
        // Initialize all deselected filters with all filters
        allDeselected = allFilters.sorted{ $0.name < $1.name }
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        
        // Get search query
        let searchQuery = searchController.searchBar.text
        
        // Sent the handling to the delegate where we:
        // 1. Query the dataBase for the query
        // 2. Update the results
        
        if let delegate = filtersViewDelegate,
            let query = searchQuery {
            delegate.searchControllerDidChange(with: query)
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let delegate = filtersViewDelegate,
            let query = searchBar.text {
            delegate.searchControllerDidChange(with: query)
            searchController.dismiss(animated: true, completion: nil)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if let delegate = filtersViewDelegate {
            delegate.searchControllerDidChange(with: nil)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Collection View Data Source:
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == genreCollectionView {
            return allDeselected.count
        } else {
            return allSelected.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier = GenreCell.identifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? GenreCell
        
        var genreFilter: GenreFilter
        // There's gotta be a better way to do this.
        if collectionView == genreCollectionView {
            genreFilter = allDeselected[indexPath.section]
        } else {
            genreFilter = allSelected[indexPath.section]
        }
        
        cell?.name = genreFilter.name
        cell?.added = genreFilter.added
        
        return cell ?? UICollectionViewCell()
    }
    
    //MARK: Collection View Delegate:
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == genreCollectionView {
            // Remove item from this array
            let genreFilter = allDeselected.remove(at: indexPath.section)
            // Flip added flag
            genreFilter.added = !genreFilter.added
            // Add to another array
            allSelected.append(genreFilter)
            
            if let delegate = filtersViewDelegate {
                delegate.filtersDidSelect(new: Genre(rawValue: genreFilter.name)!)
            }
        }
        
        if collectionView == selectedGenreCollectionView {
            // Remove item from this array
            let genreFilter = allSelected.remove(at: indexPath.section)
            // Flip added flag
            genreFilter.added = !genreFilter.added
            // Add to another array
            allDeselected.append(genreFilter)
            allDeselected = allDeselected.sorted{ $0.name < $1.name }
            
            if let delegate = filtersViewDelegate {
                delegate.filtersDidDeselect(new: Genre(rawValue: genreFilter.name)!)
            }
        }
        
        selectedGenreCollectionView.reloadData()
        genreCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {

    }
    
    //MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        var originalString: String = allDeselected[indexPath.section].name
        
        if collectionView == selectedGenreCollectionView {
            originalString = allSelected[indexPath.section].name
        }
        
        let myString: NSString = originalString as NSString
        let size: CGSize = myString.size(attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 12.0)])
        
        let sizeForItem = CGSize(width: size.width + 23, height: size.height + 10)
        
        return sizeForItem
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsetsMake(0, 3, 0, 3)
    }
    
    func setupViews() {
        // search controller
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Search here..."
        searchController.searchBar.delegate = self
        searchController.searchBar.barTintColor = UIColor.yellow
        searchController.searchBar.searchBarStyle = .prominent
        // To get rid of the gray borders
        searchController.searchBar.layer.borderColor = UIColor.yellow.cgColor
        searchController.searchBar.layer.borderWidth = 1
        
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.black], for: .normal)
        
        addSubview(searchController.searchBar)
        
        // genres
        addSubview(genresLabel)
        genresLabel.text = "GENRES:"
        genresLabel.font = UIFont.brownBold(withSize: 18)
        
        // Genre collection view
        addSubview(genreCollectionView)
        genreCollectionView.dataSource = self
        genreCollectionView.delegate   = self
        genreCollectionView.register(GenreCell.self, forCellWithReuseIdentifier: GenreCell.identifier)
        genreCollectionView.backgroundColor = UIColor.clear
        genreCollectionView.showsHorizontalScrollIndicator = false
        
        // Selected genre collection view
        addSubview(selectedGenreCollectionView)
        selectedGenreCollectionView.dataSource = self
        selectedGenreCollectionView.delegate   = self
        selectedGenreCollectionView.register(GenreCell.self, forCellWithReuseIdentifier: GenreCell.identifier)
        selectedGenreCollectionView.backgroundColor = UIColor.clear
        selectedGenreCollectionView.showsHorizontalScrollIndicator = false
        
        setupConstraints()
    }
    
}
