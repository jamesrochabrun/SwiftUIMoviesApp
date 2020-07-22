//
//  Movie.swift
//  SwiftUISearchExample
//
//  Created by James Rochabrun on 7/4/20.
//

import Foundation

struct Movie: Decodable, Identifiable {
    
    let id: Int
    let title: String
    var overview: String?
    var posterPath: String?
    var backdropPath: String?
    var releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case id
        case title
        case overview
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath) ?? ""
        backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath) ?? ""
        releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate) ?? ""
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        overview = try container.decodeIfPresent(String.self, forKey: .overview) ?? ""
    }
}

extension MovieViewModel: Searchable {
    var query: String { title }
}

struct MovieViewModel {
    
    let id: Int
    let title: String
    let overview: String
    let releaseDate: String
    let posterPathHighResURLString: String
    let posterPathLowResURLString: String
    
    init(movie: Movie) {
        self.id = movie.id
        self.title = movie.title
        self.overview = movie.overview ?? "Not available overview"
        self.releaseDate = movie.releaseDate ?? "Not available date"
        self.posterPathHighResURLString = "https://image.tmdb.org/t/p/w500" + (movie.posterPath ?? "")
        self.posterPathLowResURLString = "https://image.tmdb.org/t/p/w200" + (movie.posterPath ?? "")
    }
}
