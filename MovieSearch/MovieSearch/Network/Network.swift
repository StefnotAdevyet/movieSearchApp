//
//  Network.swift
//  MovieSearch
//
//  Created by developer on 8/15/22.
//

import UIKit


class Network {
    let apiKey: String = "b1a0a71e617a699ee81d319a065ed9ca"
    let baseUrl: String = ""
    let imgBaseUrl: String = "https://image.tmdb.org/t/p/w300/"
    
    func getMovies(searchTerm: String, completion: @escaping (Result<DataFeed, MyError>) -> Void) {
        let urlStr = "https://api.themoviedb.org/3/search/movie?api_key=\(self.apiKey)&language=en-US&query=\(formatSearchString(string: searchTerm))&page=1&include_adult=false"
        guard let url = URL(string: urlStr) else {
            print("invalid url")
            return
        }
        URLSession.shared.dataTask(with: url) { data, res, err in
            //catch any client errors
            guard err == nil else {
                completion(.failure(.client))
                return
            }
            //catch server errors
            guard let httpResponse = res as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.server))
                return
            }
            //bind data to variable
            guard let data = data else {
                return
            }
            //try to decode the data and run it with completion handler
            do {
                let decoded = try JSONDecoder().decode(DataFeed.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(.parsing))
            }
        }.resume()
    }
    
    func getImage(imgSrc: String, completion: @escaping (Result<Data, MyError>) -> Void) {
        guard let url = URL(string: imgBaseUrl + imgSrc) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, resp, error in
            guard error == nil else {
                completion(.failure(.client))
                return
            }
            guard let httpResponse = resp as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode)
            else {
                completion(.failure(.server))
                return
            }
            guard let imageData = data else {
                return
            }
            completion(.success(imageData))
        }
        task.resume()
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


