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
    
    func getMovies(searchTerm: String, completion: @escaping ([Movie]) -> Void) {
        let urlStr = "https://api.themoviedb.org/3/search/movie?api_key=\(self.apiKey)&language=en-US&query=\(formatSearchString(string: searchTerm))&page=1&include_adult=false"
        guard let url = URL(string: urlStr) else {
            print("invalid url")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("no data, networking error")
                return
            }
            guard let httpResonse = response as? HTTPURLResponse, httpResonse.statusCode == 200 else {
                print("http status code error")
                return
            }
            do {
                let feed = try JSONDecoder().decode(MovieResult.self, from: data)
                let movies = feed.results
                completion(movies)
            } catch {
                // decoding error
                print("parsing error")
                print(error)
            }
        }.resume()
    }
    
    func getImage(imageUrl: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: imageUrl) else {
            print("invalid url")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("no data, networking error")
                return
            }
            guard let httpResonse = response as? HTTPURLResponse, httpResonse.statusCode == 200
            else {
                print("http status code error")
                return
            }
            if let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }.resume()
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
