//
//  MoviesProvider.swift
//  SwiftUISearchExample
//
//  Created by James Rochabrun on 7/21/20.
//

import Foundation
import Combine

final class MoviesProvider: ObservableObject {
    
    private var cancellable: AnyCancellable?
    private let client = MovieClient()
    
    @Published var movies: [MovieViewModel] = []
    
    init() {
        cancellable = client.getFeed(.nowPlaying)
            .sink(receiveCompletion: { _ in
                // Here the actual subscriber is created. As mentioned earlier, the sink-subscriber comes with a closure, that lets us handle the received value when it’s ready from the publisher.
            },
            receiveValue: {
                self.movies = $0.results.map { MovieViewModel(movie: $0) }
            })
    }
}
