//
//  MoviesProvider.swift
//  SwiftUISearchExample
//
//  Created by James Rochabrun on 7/21/20.
//

import Foundation
import Combine

final class MoviesProvider: ObservableObject {
    
    // MARK:- Subscribers
    private var cancellable: AnyCancellable?
    
    // MARK:- Publishers
    @Published var movies: [MovieViewModel] = []

    // MARK:- Private properties
    private let client = MovieClient()
    
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
