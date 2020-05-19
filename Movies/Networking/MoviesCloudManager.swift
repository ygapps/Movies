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
    
    public func fetchMovies(completion: @escaping MoviesResponseCompletionHandler) {
        guard let moviesURL = URL(string: MoviesConstants.moviesAPI) else {
            return
        }
        
        URLSession.shared.dataTask(with: moviesURL) { (data, _, error) in
            guard let moviesData = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            do {
                let moviesResponse = try JSONDecoder().decode(MoviesResponse.self, from: moviesData)
                DispatchQueue.main.async {
                    completion(moviesResponse, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }.resume()
    }
}
