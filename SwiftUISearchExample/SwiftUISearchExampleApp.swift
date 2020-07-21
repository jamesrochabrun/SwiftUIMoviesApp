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
    
    // TODO:- verify this is the best place for this...
    @StateObject private var model = MoviesProvider()

    var body: some Scene {
        WindowGroup {
            ItemsList(model.movies) { movie in
                MovieRow(movie: movie)
            }
        }
    }
}




