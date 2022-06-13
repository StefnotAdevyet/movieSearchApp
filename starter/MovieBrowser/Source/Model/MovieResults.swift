//
//  Model.swift
//  MovieBrowser
//
//  Created by developer on 6/11/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
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
