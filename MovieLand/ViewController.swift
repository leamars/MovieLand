//
//  ViewController.swift
//  MovieLand
//
//  Created by Lea Marolt on 1/5/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import UIKit

let tableTopOffset:CGFloat = 20

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FiltersViewDelegate {
    
    // Content view - table view + offset
    var containerView: UIView = UIView()

    // Each table view cell is going to have a collection view inside
    var tableView: UITableView = UITableView()
    var tableTopConstraint = NSLayoutConstraint()
    
    // Filter View
    var filterView: FiltersView = FiltersView()
    var filtersOpen = false
    let filtersViewCompactSize:CGFloat = 180
    let filtersViewExpandedSize:CGFloat = 350
    
    let locationManager = LocationManager()
    
    // SearchController
    var searchController = UISearchController(searchResultsController: nil)
    
    enum Mode: String {
        case Default
        case Search
        
        func data(with searchQuery: String?) -> [Genre: [Movie]] {
            switch self {
            case .Default:
                return MovieStore.moviesBySection()
            case .Search:
                if let query = searchQuery {
                    return MovieStore.movies(for: query.lowercased())
                } else {
                    return MovieStore.moviesBySection()
                }
            }
        }
    }
    
    var mode: Mode = .Default
    
    var movieSections: [Genre: [Movie]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        
        tableView.dataSource = self
        tableView.delegate = self
        
        setupViews()
        
        //TODO: When in a genre - show title as "results"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    //MARK: View SetUp
    
    func setupViews() {
        
        movieSections = mode.data(with: nil)
        filterView.filtersViewDelegate = self
        
        view.backgroundColor = UIColor.yellow
        
        // Table View
        tableView.register(MovieCollectionCell.self, forCellReuseIdentifier: MovieCollectionCell.identifier)
        tableView.separatorStyle = .none
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = UIColor.yellow
        
        view.addSubview(tableView)
        
        // Filter View
        filterView.backgroundColor = UIColor.yellow
        //TODO: How to get filter view to have a nice shadow
//        filterView.layer.shadowColor = UIColor.black.cgColor
//        filterView.layer.masksToBounds = false
//        filterView.layer.shadowOffset = CGSize(width: 0, height: 5)
//        filterView.layer.shadowRadius = 5
//        filterView.layer.shadowOpacity = 0.2
        view.addSubview(filterView)
        
        setupConstraints()
    }
    
    //MARK: Search controller delegate
    func searchControllerDidChange(with searchQuery: String?) {
        if searchQuery != nil && searchQuery != "" {
            mode = .Search
            movieSections = mode.data(with: searchQuery)
        } else {
            mode = .Default
            movieSections = mode.data(with: nil)
        }
        
        tableView.reloadData()
    }
    
    func showFilters() {
        
    }
    
    //MARK: Table View:

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = MovieCollectionCell.identifier
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? MovieCollectionCell {
            
            let key = Array(movieSections.keys)[indexPath.row]
            if let collectionData = movieSections[key] {
                cell.collectionData = collectionData
            }
            cell.collectionName = key.rawValue
            cell.movieCollectionCellDelegate = self
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieSections.keys.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? MovieCollectionCell {
            cell.movieCollectionView.setContentOffset(CGPoint.zero, animated: false)
        }
    }
    

    //MARK: ScrollView:
    //TODO: 
    // - Make this animation smoother
    // - bounce when going back
    // - what to do with self??
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        if scrollView.contentOffset.y > 0 && filtersOpen {
            closeFilters()
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // when you've pulled down hal of the filters view
        if -scrollView.contentOffset.y > filterView.bounds.height/2 {
            openFilters()
        }
    }
    
    func closeFilters() {
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.4, animations: {
            self.tableTopConstraint.constant = tableTopOffset
            self.view.layoutIfNeeded()
            self.filtersOpen = false
        })
    }
    
    func openFilters() {
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.4, animations: {
            self.tableTopConstraint.constant = self.filtersViewCompactSize + tableTopOffset
            self.view.layoutIfNeeded()
            self.filtersOpen = true
        })
    }
}

extension ViewController: MovieCollectionCellDelegate {
    func movieCellWasTapped(movieCell: MovieCell) {
        if let movie = movieCell.movie {
            let detailVC = MovieDetailViewController(with: movie)
            detailVC.modalPresentationStyle = .overCurrentContext
            present(detailVC, animated: true, completion: nil)
        }
    }
}

