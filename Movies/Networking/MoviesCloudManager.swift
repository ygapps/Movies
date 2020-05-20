//
//  MoviesCloudManager.swift
//  Movies
//
//  Created by Youssef on 5/19/20.
//  Copyright © 2020 Instabug. All rights reserved.
//

import UIKit

public typealias MoviesResponseCompletionHandler = (MoviesResponse?, Error?) -> ()

class MoviesCloudManager {
    static let shared = MoviesCloudManager()
    
    private init() { }
    
    public func fetchMovies(pageNumber number: Int = 1, completion: @escaping MoviesResponseCompletionHandler) {
        
        var components = MoviesConstants.moviesAPIComponents
        components.queryItems?.append(URLQueryItem(name: "page", value: "\(number)"))

        guard let moviesURL = components.url else {
            return
        }
         
        URLSession.shared.dataTask(with: moviesURL) { (data, response, error) in
            guard let moviesData = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300 else {
                completion(nil, error)
                return
            }
            
            do {
                let moviesResponse = try JSONDecoder().decode(MoviesResponse.self, from: moviesData)
                completion(moviesResponse, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}
