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

    // Each table view cell contains a collection view
    var tableView: UITableView = UITableView()
    var tableTopConstraint = NSLayoutConstraint()
    
    // Filter View
    var filterView: FiltersView = FiltersView()
    var filtersOpen = false
    let filtersViewCompactSize:CGFloat = 180
    let filtersViewExpandedSize:CGFloat = 400
    
    // User View
    let userView: UserView = UserView(with: nil, numberRated: 0) // Should get the right number
    
    // Presentation
    var isPresenting: Bool = false
    
    // SearchController
    var searchController = UISearchController(searchResultsController: nil)
    
    // Filtering
    var filterGenres: [Genre] = []
    
    enum DisplayMode: String {
        case Default
        case Search
        case GenreSearch
        
        func movieData(for movies: [Movie], with searchQuery: String?, for genres: [Genre]) -> [MovieSection: [Movie]] {
            switch self {
            case .Default:
                return MovieStore.moviesBySection(movies: movies)
            case .Search:
                if let query = searchQuery {
                    return MovieStore.searchResults(on: movies, for: query.lowercased())
                } else {
                    return MovieStore.moviesBySection(movies: movies)
                }
            case .GenreSearch:
                return MovieStore.genreResults(on: movies, for: genres)
            }
        }
    }
    
    var mode: DisplayMode = .Default
    
    var allMovies:[Movie] = []
    var movieSections: [MovieSection: [Movie]] = [:]
    
    var user: User?
    
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
        
        // Ask for signup/login
        guard user == nil else { return }
        
        askForSignUp()
    }
    
    //MARK: Table View:

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = MovieCollectionCell.identifier
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? MovieCollectionCell {
            
            var collectionName: String = ""
            var collectionData: [Movie] = []
            
            let sortedSections = Array(movieSections.keys).sorted{ $0.rawValue < $1.rawValue }
            let cellSection = sortedSections[indexPath.row]
            
            if let cellData = movieSections[cellSection] {
                switch cellSection {
                case .AlreadyRated:
                    cell.backgroundColor = UIColor(colorLiteralRed: 200/255, green: 200/255, blue: 200/255, alpha: 1.0)
                case .TopPicks:
                    cell.backgroundColor = UIColor.yellow
                case .Rate, .Recent:
                    cell.backgroundColor = UIColor.white
                }
                collectionName = cellSection.sectionName()
                collectionData = cellData
                
            }

            cell.collectionName = collectionName
            cell.collectionData = collectionData
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

// MARK: Sign Up
extension ViewController {
    func askForSignUp() {
        // Show alert to Sign Up/Log In
        let alertController = UIAlertController(title: "Sign Up/Login", message:
            "Hey, please sign up or login to use this app!", preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Username"
            textField.clearButtonMode = .whileEditing
            textField.borderStyle = UITextBorderStyle.roundedRect
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Password"
            textField.clearButtonMode = .whileEditing
            textField.borderStyle = UITextBorderStyle.roundedRect
            textField.isSecureTextEntry = true
        }
        
        let signUp = UIAlertAction(title: "Sign Up", style: .default) { (action) in
            guard let username = alertController.textFields?[0].text else { return }
            self.signUp(with: username, and: "Password")
        }
        
        let login = UIAlertAction(title: "Login", style: .default) { (action) in
            guard let username = alertController.textFields?[0].text else { return }
            self.signUp(with: username, and: "Password")
        }
        
        alertController.addAction(signUp)
        alertController.addAction(login)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func signUp(with username: String, and password: String) {
        user = User(with: username)
        userView.user = user
        
        // Load Data
        allMovies = (UIApplication.shared.delegate as! AppDelegate).movies
        movieSections = mode.movieData(for: allMovies, with: nil, for: [])
        tableView.reloadData()
    }
}

//MARK: Search controller delegate
extension ViewController: FiltersViewDelegate {

    func searchControllerDidChange(with searchQuery: String?) {
        if searchQuery != nil && searchQuery != "" {
            mode = .Search
        } else {
            mode = .Default
        }
        
        movieSections = mode.movieData(for: allMovies, with: searchQuery, for: filterGenres)
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
        } else {
            mode = .Default
        }
        
        movieSections = mode.movieData(for: allMovies, with: nil, for: filterGenres)
        
        tableView.reloadData()
    }
}

//MARK: QuickMovieDetails & MovieDetails Delegate
extension ViewController: QuickMovieDetailsDelegate, MovieDetailsDelegate {
    func quickMovieDidDismiss() {
        view.isUserInteractionEnabled = true
        isPresenting = false
    }
    
    func userRating(for movie: Movie, wasChanged toRating: Double) {
        update(movie: movie, withRating: toRating)
    }
    
    func movie(updated movie: Movie, with rating: Double) {
        update(movie: movie, withRating: rating)
    }
    
    private func update(movie: Movie, withRating: Double) {
        let movieIndex = allMovies.index(of: movie)
        
        allMovies[movieIndex!].yourActualRating = withRating
        allMovies[movieIndex!].movieSection = .AlreadyRated
        
        movieSections = mode.movieData(for: allMovies, with: nil, for: filterGenres)
        if let alreadyRatedCount = movieSections[MovieSection.AlreadyRated]?.count {
            userView.numberRated = alreadyRatedCount
        }
        tableView.reloadData()
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


