//
//  SwiftUISearchExampleApp.swift
//  SwiftUISearchExample
//
//  Created by James Rochabrun on 7/2/20.
//

import SwiftUI

@main
struct SwiftUISearchExampleApp: App {
    
    @StateObject private var model = MovieModel()

    var body: some Scene {
        WindowGroup {
            ItemsList(model.items) { movie in
                MovieRow(movie: movie)
            }
        }
    }
}


final class MovieModel: ObservableObject {
    
    private let client = MovieClient()
    
    @Published var items: [Movie] = []
    
    init() {
        client.getFeed(from: .nowPlaying) { result in
            switch result {
            case .success(let movieFeedResult):
                guard let movieResults = movieFeedResult?.results else { return }
                self.items = movieResults
                dump(movieResults)
            case .failure(let error):
                print("the error \(error)")
            }
        }
    }
}
