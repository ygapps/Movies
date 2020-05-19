//
//  Movie.swift
//  Movies
//
//  Created by Youssef on 5/19/20.
//  Copyright © 2020 Instabug. All rights reserved.
//

import Foundation

public struct Movie: Codable {
    let title, overview, releaseDate, posterPath: String
    let popularity, voteAverage: Double
    let voteCount, id: Int
    let video, adult: Bool
    let backdropPath, originalMovieTitle: String
    let originalMovieLanguage: MovieLanguage
    let genreIDS: [Int]

    enum CodingKeys: String, CodingKey {
        case popularity
        case voteCount = "vote_count"
        case video
        case posterPath = "poster_path"
        case id, adult
        case backdropPath = "backdrop_path"
        case originalMovieLanguage = "original_language"
        case originalMovieTitle = "original_title"
        case genreIDS = "genre_ids"
        case title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
    }
}


