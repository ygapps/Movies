//
//  PersonalMovie.swift
//  Movies
//
//  Created by Youssef on 5/19/20.
//  Copyright © 2020 Instabug. All rights reserved.
//

import UIKit

public struct PersonalMovie: CustomStringConvertible {
    let posterImage: UIImage
    let movieTitle: String
    let movieOverview: String
    let movieReleaseDate: Date
    
    public var description: String {
        return "Image = \(posterImage)\nMovie Title: \(movieTitle)\nMovie Overview: \(movieOverview)\nMovie Release Date: \(movieReleaseDate)"
    }
}
