//
//  Network.swift
//  MovieSearch
//
//  Created by developer on 8/15/22.
//

import UIKit



protocol MovieServiceProtocol {
    func getMovies(completion: @escaping (_ success: Bool, _ results: DataFeed?, _ error: String?) -> ())
}

enum MyError: String, Error {
    case client
    case server
    case reachability
    case parsing
}

class Network: MovieServiceProtocol {
    func getMovies(completion: @escaping (Bool, DataFeed?, String?) -> ()) {
        HttpRequestHelper().GET(url: "https://api.themoviedb.org/3/search/movie?api_key=b1a0a71e617a699ee81d319a065ed9ca&language=en-US&query=avengers&page=1&include_adult=false", params: ["":""], httpHeader: .application_json) { success, data in
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

extension Network {
    func formatSearchString(string: String) -> String {
        let words: [String] = string.components(separatedBy: " ")
        if words.count > 1 {
            return words.joined(separator: "%20")
        }
        return words[0]
    }
}


//let apiKey: String = "b1a0a71e617a699ee81d319a065ed9ca"
//let baseUrl: String = ""
//let imgBaseUrl: String = "https://image.tmdb.org/t/p/w300/"
//
//let urlStr = "https://api.themoviedb.org/3/search/movie?api_key=\(self.apiKey)&language=en-US&query=\(formatSearchString(string: searchTerm))&page=1&include_adult=false"
