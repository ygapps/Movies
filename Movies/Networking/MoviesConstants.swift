//
//  MoviesConstants.swift
//  Movies
//
//  Created by Youssef on 5/19/20.
//  Copyright © 2020 Instabug. All rights reserved.
//

import Foundation

public enum MoviesConstants {
    public static var moviesAPIComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        components.path = "/3/discover/movie"
        components.queryItems = [
            URLQueryItem(name: "api_key", value: "acea91d2bff1c53e6604e4985b6989e2")
        ]
        
        return components
    }
    
    public static var moviesPostersAPI: String {
        return "https://image.tmdb.org/t/p/w500"
    }
}
