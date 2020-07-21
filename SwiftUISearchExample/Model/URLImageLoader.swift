//
//  URLImageLoader.swift
//  SwiftUISearchExample
//
//  Created by James Rochabrun on 7/21/20.
//

import Foundation
import Combine
import UIKit

final class URLImageLoader: ObservableObject {
    
    @Published var image: UIImage?
    
    static let graphicsBaseURL = "https://image.tmdb.org/t/p/w500"

    private var urlString: String?
    private var urlLowResString: String?
    private let errorImage: UIImage?
    
    init(urls: (urlString: String?, lowResURLString: String?), errorImage: UIImage?) {
        self.urlString = Self.graphicsBaseURL + (urls.urlString ?? "")
        self.urlLowResString = urls.lowResURLString
        self.errorImage = errorImage
        self.load()
    }
    
    func load() {
        guard let urlString = urlString,
              let url = URL(string: urlString)
        else { return }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTaskPublisher(for: request)
            .tryCatch { error -> URLSession.DataTaskPublisher in
                guard
                    error.networkUnavailableReason == .constrained,
                    let lowResURLString = self.urlLowResString,
                    let lowResURL = URL(string: lowResURLString) else {
                    throw error
                }
                return URLSession.shared.dataTaskPublisher(for: lowResURL)
            }
            .tryMap { data, response -> UIImage in
                guard let response = response as? HTTPURLResponse, response.statusCode == 200,
                      let image = UIImage(data: data)
                else {
                    throw APIError.responseUnsuccessful
                }
                return image
            }
            .retry(1)
            .replaceError(with: errorImage)
            .receive(on: DispatchQueue.main)
            .assign(to: $image)
    }
}
