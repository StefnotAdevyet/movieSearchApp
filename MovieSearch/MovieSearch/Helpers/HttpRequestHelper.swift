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




class HttpRequestHelper {
    func GET(url: String, params: [String: String], httpHeader: HTTPHeaderFields, completion: @escaping (Bool, Data?) -> ()) {
        //create URLComponent type variable from url string?
        guard var components = URLComponents(string: url) else {
            print("Error: Cannot create URLComponents")
            return
        }
        //add the url query parameters to the URLComponent variable
        components.queryItems = params.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        
        guard let url = components.url else {
            print("Error: Cannot create url")
            return
        }
        
        //create url request from url and set request method as GET
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        //use switch statement with HTTPHeaderfields enum to set the content-type of the url request
        switch httpHeader {
        case .application_json:
            request.setValue("application_json", forHTTPHeaderField: "Content-Type")
        case .application_x_www_form_urlencoded:
            request.setValue("application_x_www_form_urlencoded", forHTTPHeaderField: "Content-Type")
        case .none:
            break
        }
        
        let config = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: config)
        //run the data task on the session check for errors, unwrap the data, decode the data if necessary, unwrap the resopnse, run completion handler with the data
        session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: Problem calling GET")
                print(error!)
                completion(false, nil)
                return
            }
            
            guard let data = data else {
                print("Error: did not receive data")
                completion(false, nil)
                return
            }

            guard let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                completion(false, nil)
                return
            }
            completion(true, data)
        }.resume()
    }
}

