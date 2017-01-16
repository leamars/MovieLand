//
//  MovieData.swift
//  MovieLand
//
//  Created by Lea Marolt on 1/7/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import UIKit

// File for fake movie data

enum Genre: String {
    case Action
    case Adventure
    case Horror
    case ScienceFiction
    case Comedy
    case Drama
    case Documentary
    case Tragedy
    case Independent
    case War
    case Western
    case Fantasy
    case Romance
    case Thriller
    case FilmNoir
    case Mystery
    case Crime
    case Musical
    case Animation
    case Children
    case Music
    case Family
    case History
    
    static var count: Int { return Genre.History.hashValue + 1}
}

enum MovieSection: Int {
    case Rate
    case TopPicks
    case Recent
    case AlreadyRated
    
    func sectionName() -> String {
        switch self {
        case .TopPicks:
            return "Top Picks"
        case .AlreadyRated:
            return "Already Rated"
        case .Recent:
            return "Recent"
        case .Rate:
            return "Rate"
        }
    }
    
    static var count: Int { return MovieSection.AlreadyRated.hashValue + 1}
}

struct Filters {
    static func genres() -> [GenreFilter] {
        let allGenres: [Genre] = [.Action, .Adventure, .Horror, .ScienceFiction, .Comedy, .Drama, .Documentary, .Tragedy, .Independent, .War, .Western, .Fantasy, .Romance, .Thriller, .FilmNoir, .Mystery, .Crime, .Musical, .Animation, .Children, .Music, .Family, .History]
        
        let allGenreFilters = allGenres.map { GenreFilter(name: $0.rawValue) }
        
        return allGenreFilters
    }
}

class GenreFilter {
    let name: String
    var added: Bool = false
    
    init(name: String) {
        self.name = name
    }
}

enum AdmissionRating: String {
    case PG13
    case R
    case G
    case PG
}

struct MovieStore {
    
    static func movies() -> [Movie] {
        return parseMovies()
    }
    
    static func moviesBySection(movies: [Movie]) -> [MovieSection : [Movie]] {
        var moviesBySection: [MovieSection:[Movie]] = [:]
        for movie in movies {
            if let existingSection = moviesBySection[movie.movieSection] {
                var sectionCopy = existingSection
                sectionCopy.append(movie)
                moviesBySection[movie.movieSection] = sectionCopy
            } else {
                moviesBySection[movie.movieSection] = [movie]
            }
        }
        
        return moviesBySection
    }
    
    static func genreResults(on movies: [Movie], for genres: [Genre]) -> [MovieSection: [Movie]] {
        let moviesToKeep = movies.filter { (movie) -> Bool in
            return movie.genres.filter({ (genre) -> Bool in
                return genres.index(of: genre) != nil
            }).count > 0
        }
        
        return moviesBySection(movies: moviesToKeep)
    }
    
    static func searchResults(on movies: [Movie], for query:String) -> [MovieSection : [Movie]] {
        // search by actor, director, year, languages,
        
        let titleResults = movies.filter { (movie) -> Bool in
            return movie.title.components(separatedBy: " ").filter({ (titlePart) -> Bool in
                return titlePart.lowercased() == query
            }).count > 0
        }
        
        let directorResults = movies.filter { (movie) -> Bool in
            return movie.director.components(separatedBy: " ").filter({ (directorPart) -> Bool in
                return directorPart.lowercased() == query
            }).count > 0
        }

        let yearResults = movies.filter{ String($0.year) == query }
        
        let castResults = movies.filter { (movie) -> Bool in
            return movie.cast.filter({ (castMember) -> Bool in
                return castMember.lowercased() == query
            }).count > 0
        }
        
        let languageResults = movies.filter { (movie) -> Bool in
            return movie.languages.filter({ (language) -> Bool in
                return language.lowercased() == query
            }).count > 0
        }
        
        let combinedResults = titleResults + directorResults + yearResults + castResults + languageResults
        
        return moviesBySection(movies: combinedResults)
    }
    
    private static func parseMovies() -> [Movie] {
        
        let filePath = Bundle.main.path(forResource: "Movies", ofType: "plist")!
        let dictionary = NSDictionary(contentsOfFile: filePath)!
        let movieData = dictionary["Movies"] as! [[String : AnyObject]]
        
        let movies = movieData.map { dict -> Movie in
            let genreStrings = dict["genres"] as! [String]
            let genres: [Genre] = genreStrings.filter{ Genre(rawValue: $0) != nil }
                .map{ Genre(rawValue: $0.trimmingCharacters(in: .whitespaces))! }
            
            return Movie(
                title: dict["title"] as! String,
                year: dict["year"] as! Int,
                length: dict["length"] as! Int,
                languages: dict["languages"] as! [String],
                cast: dict["cast"] as! [String],
                director: dict["director"] as! String,
                genres: genres,
                rating: dict["rating"] as! Double,
                description: dict["description"] as! String,
                admissionRating: AdmissionRating(rawValue: dict["admissionRating"] as! String)!,
                image: UIImage(named: dict["imageName"] as! String)!)
        }
        
        return movies
    }
}

class Movie: Equatable {
    let title: String
    let year: Int
    let length: Int // Minutes
    let languages: [String]
    let cast: [String]
    let director: String
    let genres: [Genre]
    let rating: Double
    let description: String
    let admissionRating: AdmissionRating
    let yourPredictedRating: Double
    var yourActualRating: Double?
    var movieSection: MovieSection
    let image: UIImage
    
    init(title: String, year: Int, length: Int, languages: [String], cast: [String], director: String, genres: [Genre], rating: Double, description: String, admissionRating: AdmissionRating, image: UIImage) {
        self.title                        = title
        self.year                         = year
        self.length                       = length
        self.languages                    = languages
        self.cast                         = cast
        self.director                     = director
        self.genres                       = genres
        self.rating                       = rating
        self.description                  = description
        self.admissionRating              = admissionRating
        self.image                        = image
        // This defaults to audience rating + or - 0.5 for presentation sake
        // We're not building a real prediction engine here
        let random                        = Int(arc4random_uniform(3)) - 1
        let yourPredictedRating           = rating + Double(random) * 0.5
        self.yourPredictedRating          = yourPredictedRating > 5 ? 5 : yourPredictedRating
        self.yourActualRating             = nil
        let movieSections: [MovieSection] = [.TopPicks, .Recent, .Rate]
        self.movieSection                 = movieSections[random+1]
    }

    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.title == rhs.title &&
        lhs.year == rhs.year &&
        lhs.length == rhs.length &&
        lhs.languages == rhs.languages &&
        lhs.cast == rhs.cast &&
        lhs.director == rhs.director &&
        lhs.genres == rhs.genres &&
        lhs.rating == rhs.rating &&
        lhs.description == rhs.description &&
        lhs.admissionRating == rhs.admissionRating
    }
}
