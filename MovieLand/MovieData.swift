//
//  MovieData.swift
//  MovieLand
//
//  Created by Lea Marolt on 1/7/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import Foundation
import UIKit

// File for fake movie data

enum Genre: String {
    case Action
    case Adventure
    case Horror
    case ScienceFiction // This might cause issues if it's categorized as SciFi (or if there's spaces)
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
    // Non genre cases - these could be an extension ?
    case Recommended
    case Favorites
    case Wishlist
    
    static var count: Int { return Genre.Wishlist.hashValue + 1}
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
    
    static func moviesBySection() -> [Genre: [Movie]] {
        
        var moviesBySection: [Genre:[Movie]] = [:]
        for movie in movies() {
            for genre in movie.genres {
                if let existingSection = moviesBySection[genre] {
                    var sectionCopy = existingSection
                    sectionCopy.append(movie)
                    moviesBySection[genre] = sectionCopy
                } else {
                    moviesBySection[genre] = [movie]
                }
            }
        }
        
        return moviesBySection
    }
    
    static func movies(for searchQuery: String) -> [Genre: [Movie]] {
        
        // search by actor, director, year, languages, 
        var searchResults: [Genre: [Movie]] = [:]
        
        let titleResults = movies().filter{ $0.title.lowercased() == searchQuery }
        let directorResults = movies().filter{ $0.director.lowercased() == searchQuery }
        let yearResults = movies().filter{ String($0.year) == searchQuery }

        var combinedResults = titleResults + directorResults + yearResults
        
        let castResults = movies().filter { (movie) -> Bool in
            return movie.cast.filter({ (castMember) -> Bool in
                return castMember.lowercased() == searchQuery
            }).count > 0
        }
        
        let languageResults = movies().filter { (movie) -> Bool in
            return movie.languages.filter({ (language) -> Bool in
                return language.lowercased() == searchQuery
            }).count > 0
        }

        combinedResults = combinedResults + castResults + languageResults
        
        searchResults[.Recommended] = combinedResults
        return searchResults
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
                rating: dict["rating"] as! Float,
                description: dict["description"] as! String,
                admissionRating: AdmissionRating(rawValue: dict["admissionRating"] as! String)!,
                image: UIImage(named: dict["imageName"] as! String)!)
        }
        
        return movies
    }
}

class Movie {
    let title: String
    let year: Int
    let length: Int // Minutes
    let languages: [String]
    let cast: [String]
    let director: String
    let genres: [Genre]
    let rating: Float
    let description: String
    let admissionRating: AdmissionRating
    let image: UIImage
    
    init(title: String, year: Int, length: Int, languages: [String], cast: [String], director: String, genres: [Genre], rating: Float, description: String, admissionRating: AdmissionRating, image: UIImage) {
        self.title = title
        self.year = year
        self.length = length
        self.languages = languages
        self.cast = cast
        self.director = director
        self.genres = genres
        self.rating = rating
        self.description = description
        self.admissionRating = admissionRating
        self.image = image        
    }
}
