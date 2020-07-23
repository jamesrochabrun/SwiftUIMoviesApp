//
//  SwiftUIMoviesApp.swift
//  SwiftUISearchExample
//
//  Created by James Rochabrun on 7/2/20.
//

import SwiftUI

@main
struct SwiftUIMoviesApp: App {
    
    @StateObject private var model = MoviesProvider()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                List(model.movies, id: \.id) { movie in
                    MovieRow(movie: movie)
                }
            }
        }
    }
}




