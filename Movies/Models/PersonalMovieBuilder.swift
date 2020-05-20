//
//  MovieBuilder.swift
//  Movies
//
//  Created by Youssef on 5/19/20.
//  Copyright © 2020 Instabug. All rights reserved.
//

import UIKit

public enum PersonalMovieBuilderError: Error {
    case moviePosterImageNotFound
    case movieTitleNotFound
    case movieOverviewNotFound
    case movieReleaseDateNotFound
}

public class MovieBuilder {
    
    public private(set) var posterImage: UIImage?
    public private(set) var movieTitle: String?
    public private(set) var movieOverview: String?
    public private(set) var movieReleaseDate: Date?
    
    public func setPosterImage(_ image: UIImage) {
        self.posterImage = image
    }
    
    public func setMovieTitle(_ title: String) {
        self.movieTitle = title
    }
    
    public func setMovieOverview(_ overview: String) {
        self.movieOverview = overview
    }
    
    public func setMovieReleaseDate(_ releaseDate: Date) {
        self.movieReleaseDate = releaseDate
    }
    
    public func build() throws -> PersonalMovie {
        guard let posterImage = posterImage else {
            throw PersonalMovieBuilderError.moviePosterImageNotFound
        }
        
        guard let movieTitle = movieTitle else {
            throw PersonalMovieBuilderError.movieTitleNotFound
        }
        
        guard let movieOverview = movieOverview else {
            throw PersonalMovieBuilderError.movieOverviewNotFound
        }
        
        guard let movieReleaseDate = movieReleaseDate else {
            throw PersonalMovieBuilderError.movieReleaseDateNotFound
        }
        
        return PersonalMovie(posterImage: posterImage, movieTitle: movieTitle, movieOverview: movieOverview, movieReleaseDate: movieReleaseDate)
    }
}
