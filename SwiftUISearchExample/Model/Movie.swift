//
//  Movie.swift
//  SwiftUISearchExample
//
//  Created by James Rochabrun on 7/4/20.
//

import Foundation

final class Movie: Decodable, Identifiable {
    
    static let emptyMovie = Movie(id: 0,
                                  title: "noen",
                                  poster_path: "none",
                                  overview: "none",
                                  releaseDate: "none",
                                  backdrop_path: "none",
                                  release_date: "none")
    
    var id: Int
    var title: String
    let poster_path: String?
    let overview: String?
    let releaseDate: String?
    let backdrop_path: String?
    let release_date: String?
    
    init(id: Int, title: String, poster_path: String, overview: String, releaseDate: String, backdrop_path: String, release_date: String) {
        self.id = id
        self.title = title
        self.poster_path = poster_path
        self.overview = overview
        self.releaseDate = releaseDate
        self.backdrop_path = backdrop_path
        self.release_date = release_date
    }
}

extension Movie: Searchable {
    var query: String { title }
}
