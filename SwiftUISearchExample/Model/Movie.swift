//
//  Movie.swift
//  SwiftUISearchExample
//
//  Created by James Rochabrun on 7/4/20.
//

import Foundation

struct Movie: Decodable, Identifiable {
    
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
}

extension Movie: Searchable {
    var query: String { title }
}
