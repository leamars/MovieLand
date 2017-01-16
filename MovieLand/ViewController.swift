//
//  ViewController.swift
//  MovieLand
//
//  Created by Lea Marolt on 1/5/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import UIKit

let tableTopOffset:CGFloat = 20

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Content view - table view + offset
    var containerView: UIView = UIView()

    // Each table view cell is going to have a collection view inside
    var tableView: UITableView = UITableView()
    var tableTopConstraint = NSLayoutConstraint()
    
    // Filter View
    var filterView: FiltersView = FiltersView()
    var filtersOpen = false
    let filtersViewCompactSize:CGFloat = 180
    let filtersViewExpandedSize:CGFloat = 360
    
    // User View
    let userView: UserView = UserView(numberRated: 76) // Should get the right number
    
    let locationManager = LocationManager()
    
    // Presentation
    var isPresenting: Bool = false
    
    // SearchController
    var searchController = UISearchController(searchResultsController: nil)
    
    // Filtering
    var filterGenres: [Genre] = []
    
    // Empty Vie
    var emptyView = UIImageView(image: UIImage(named: "movieLandSad")!)
    
    enum Mode: String {
        case Default
        case Search
        case GenreSearch
        
        func movieData(for movies: [Movie], with searchQuery: String?, for genres: [Genre]) -> [Genre: [Movie]] {
            switch self {
            case .Default:
                return MovieStore.dividedBySection(movies: movies)
            case .Search:
                if let query = searchQuery {
                    return MovieStore.searchResults(on: movies, for: query.lowercased())
                } else {
                    return MovieStore.dividedBySection(movies: movies)
                }
            case .GenreSearch:
                return MovieStore.genreResults(on: movies, for: genres)
            }
        }
    }
    
    var mode: Mode = .Default
    
    var allMovies:[Movie] = []
    var movieSections: [Genre: [Movie]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        tableView.dataSource = self
        tableView.delegate = self
        
        allMovies = (UIApplication.shared.delegate as! AppDelegate).movies
        
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
        
        movieSections = mode.movieData(for: allMovies, with: nil, for: [])
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
        view.addSubview(filterView)
        
        // User View
        view.addSubview(userView)
        
        setupConstraints()
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
        // when you've pulled down half of the filters view
        
        if -scrollView.contentOffset.y > filterView.bounds.height/2 {
            
            if !filtersOpen {
                openFilters()
            } else {
                openUserAccount()
            }
        }
        
    }
    
    func closeFilters() {
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.4, animations: {
            self.tableTopConstraint.constant = 0
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
    
    func openUserAccount() {
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.4, animations: {
            self.tableTopConstraint.constant = self.filtersViewExpandedSize + tableTopOffset
            self.view.layoutIfNeeded()
            self.filtersOpen = true
        })
    }
    
    func closeUserAccount() {
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.4, animations: {
            self.tableTopConstraint.constant = 0
            self.view.layoutIfNeeded()
            self.filtersOpen = false
        })
    }
}

//MARK: Search controller delegate
extension ViewController: FiltersViewDelegate {

    func searchControllerDidChange(with searchQuery: String?) {
        if searchQuery != nil && searchQuery != "" {
            mode = .Search
            movieSections = mode.movieData(for: allMovies, with: searchQuery, for: [])
        } else {
            mode = .Default
            movieSections = mode.movieData(for: allMovies, with: nil, for: [])
        }
        
        tableView.reloadData()
    }
    
    func filtersDidSelect(new genre: Genre) {
        mode = .GenreSearch
        filterGenres.append(genre)
        
        movieSections = mode.movieData(for: allMovies, with: nil, for: filterGenres)
        
        tableView.reloadData()
    }
    
    func filtersDidDeselect(new genre: Genre) {
        let index = filterGenres.index(of: genre)
        filterGenres.remove(at: index!)
        if filterGenres.count > 0 {
            mode = .GenreSearch
            movieSections = mode.movieData(for: allMovies, with: nil, for: filterGenres)
        } else {
            mode = .Default
            movieSections = mode.movieData(for: allMovies, with: nil, for: [])
        }
        
        tableView.reloadData()
    }
}

//MARK: QuickMovieDetails Delegate
extension ViewController: QuickMovieDetailsDelegate {
    func quickMovieDidDismiss() {
        view.isUserInteractionEnabled = true
        isPresenting = false
    }
    
    func userRating(for movie: Movie, wasChanged toRating: Double) {
        let movieIndex = allMovies.index(of: movie)
        let newMovie = movie
        newMovie.yourActualRating = toRating
        allMovies[movieIndex!] = newMovie
    }
}

//MARK: MovieDetailsDelegate Delegate
extension ViewController: MovieDetailsDelegate {
    func movie(updated movie: Movie, with rating: Double) {
        let movieIndex = allMovies.index(of: movie)
        let newMovie = movie
        newMovie.yourActualRating = rating
        allMovies[movieIndex!] = newMovie
    }
}

//MARK: MovieCollectionCell Delegate
extension ViewController: MovieCollectionCellDelegate {
    
    func movieCellWasTapped(movieCell: MovieCell) {
        if let movie = movieCell.movie {
            let detailVC = MovieDetailViewController(with: movie)
            detailVC.delegate = self
            detailVC.modalPresentationStyle = .overCurrentContext
            present(detailVC, animated: true, completion: nil)
        }
    }
    
    func forceTouchReceived(for movieCell: MovieCell, at point: CGPoint) {
        view.isUserInteractionEnabled = false
        if let movie = movieCell.movie, !isPresenting {
            let detailVC = QuickMovieDetailsViewController(with: movie, touchReceivedAt: point)
            detailVC.modalPresentationStyle = .overCurrentContext
            detailVC.delegate = self
            isPresenting = true
            present(detailVC, animated: false, completion: nil)
        }
    }
}


