//
//  SwiftUISearchExampleApp.swift
//  SwiftUISearchExample
//
//  Created by James Rochabrun on 7/2/20.
//

import SwiftUI
import Combine

@main
struct SwiftUISearchExampleApp: App {
    
    @StateObject private var model = MovieCombineModel()

    var body: some Scene {
        WindowGroup {
            ItemsList(model.movies) { movie in
                MovieRow(movie: movie)
            }
        }
    }
}


final class MovieCombineModel: ObservableObject {
    
    private var cancellable: AnyCancellable?
    private let client = MovieClient()
    
    @Published var movies: [Movie] = []
    
    init() {
        cancellable = client.getFeed(.nowPlaying)
            .sink(receiveCompletion: { _ in
             // Here the actual subscriber is created. As mentioned earlier, the sink-subscriber comes with a closure, that lets us handle the received value when it’s ready from the publisher.
            },
                  receiveValue: {
                    self.movies = $0.results // 7
                  })
    }
}
