//
//  MovieClient.swift
//  SwiftUISearchExample
//
//  Created by James Rochabrun on 7/4/20.
//

import Foundation
import Combine

class MovieClient: CombineAPI {
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func getFeed(_ feedKind: MovieFeed) -> AnyPublisher<MovieFeedResult, Error> {
        execute(feedKind.request, decodingType: MovieFeedResult.self)
    }
}

protocol CombineAPI {
    var session: URLSession { get }
    func execute<T>(_ request: URLRequest,
                            decodingType: T.Type) -> AnyPublisher<T, Error> where T: Decodable
}

extension CombineAPI {
    
    func execute<T>(_ request: URLRequest,
                    decodingType: T.Type) -> AnyPublisher<T, Error> where T: Decodable {
        
        return session.dataTaskPublisher(for: request)
            .tryMap {
                guard let response = $0.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw APIError.responseUnsuccessful
                }
                return $0.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
