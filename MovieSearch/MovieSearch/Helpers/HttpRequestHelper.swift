//
//  HttpRequestHelper.swift
//  MovieSearch
//
//  Created by developer on 8/17/22.
//

//In this example, we have a file with the name HttpRequestHelper. Inside this class, we have a GET method that takes as parameters a URL, the request parameters (If they exist), and an HTTP Header and returns the results with the escaping closure complete.

import Foundation


enum HTTPHeaderFields {
    case application_json
    case application_x_www_form_urlencoded
    case none
}

enum MyError: String, Error {
    case client
    case server
    case reachability
    case parsing
}


class HttpRequestHelper {
    func GET(url: String, params: [String: String], httpHeader: HTTPHeaderFields, completion: @escaping (Bool, Data?) -> ()) {
        
    }
}
