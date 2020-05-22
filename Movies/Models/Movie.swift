//
//  Movie.swift
//  Movies
//
//  Created by Youssef on 5/19/20.
//  Copyright © 2020 Instabug. All rights reserved.
//

import Foundation

public struct Movie: Codable, Equatable {
    let title, overview, releaseDate: String
    let posterPath: String?
    let popularity, voteAverage: Double
    let voteCount, id: Int
    let video, adult: Bool
    let backdropPath: String?
    let originalMovieTitle: String
    let originalMovieLanguage: String
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
    
    public func posterImageURL() -> URL? {
        guard let posterPath = self.posterPath else { return nil }
        let posterImagePath = MoviesConstants.moviesPostersAPI + posterPath
        guard let posterImageURL = URL(string: posterImagePath) else { return nil }
        return posterImageURL
    }
}


