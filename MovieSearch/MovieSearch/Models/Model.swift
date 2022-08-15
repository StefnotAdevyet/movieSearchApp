//
//  Model.swift
//  MovieSearch
//
//  Created by developer on 8/15/22.
//

import Foundation

struct MovieResult: Codable {
    let page: Int
    let results: [Movie]
    let total_pages: Int
    let total_results: Int
}

struct Movie: Codable {
    let original_title: String
    let release_date: String
    let vote_average: Float
    let overview: String
    let poster_path: String?
}

