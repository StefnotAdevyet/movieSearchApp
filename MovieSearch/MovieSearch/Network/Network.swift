//
//  Network.swift
//  MovieSearch
//
//  Created by developer on 8/15/22.
//

import UIKit



protocol MovieServiceProtocol {
    func getMovies(movie: String, completion: @escaping (_ success: Bool, _ results: DataFeed?, _ error: String?) -> ())
}

enum MyError: String, Error {
    case client
    case server
    case reachability
    case parsing
}

class Network: MovieServiceProtocol {
    func getMovies(movie: String, completion: @escaping (Bool, DataFeed?, String?) -> ()) {
        let params: [URLQueryItem] = [
           URLQueryItem(name: "api_key", value: "b1a0a71e617a699ee81d319a065ed9ca"),
           URLQueryItem(name: "language", value: "en-US"),
           URLQueryItem(name: "query", value: movie),
           URLQueryItem(name: "page", value: "1"),
           URLQueryItem(name: "include_adult", value: "false")
        ]
        HttpRequestHelper().GET(url: "", params: params, httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(DataFeed.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, "Error: Movie Parsing failed")
                }
            } else {
                completion(false, nil, "Error: Get request failed")
            }
        }
    }
}
