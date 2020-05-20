//
//  MoviesTests.swift
//  MoviesTests
//
//  Created by Youssef on 5/18/20.
//  Copyright © 2020 Instabug. All rights reserved.
//

import XCTest
@testable import Movies

class MoviesTests: XCTestCase {
    
    func testDateExtension() {
        let dateString = "2019-05-20"
        XCTAssertEqual(dateString.movieReleaseDate?.movieReleaseDateString, "May 20, 2019")
    }
    
    func testPersonalMovieBuilder() {
        let builder = PersonalMovieBuilder()
        builder.setMovieTitle("The Platform")
        builder.setMovieOverview("Epic!")
        builder.setMovieReleaseDate("2020-02-21".movieReleaseDate ?? Date())
        XCTAssertThrowsError(try builder.build()) {
            error in
            XCTAssertEqual(error as! PersonalMovieBuilderError, PersonalMovieBuilderError.moviePosterImageNotFound)
        }
    }
    
    func testMovieCoding() throws {
        let movie = Movie(title: "The Platform",
                          overview: "A mysterious place, an indescribable prison, a deep hole. An unknown number of levels. Two inmates living on each level. A descending platform containing food for all of them. An inhuman fight for survival, but also an opportunity for solidarity…",
                          releaseDate: "2019-11-08",
                          posterPath: "/8ZX18L5m6rH5viSYpRnTSbb9eXh.jpg",
                          popularity: 63.406,
                          voteAverage: 7.1,
                          voteCount: 3009,
                          id: 619264,
                          video: false,
                          adult: false,
                          backdropPath: "/3tkDMNfM2YuIAJlvGO6rfIzAnfG.jpg",
                          originalMovieTitle: "El hoyo",
                          originalMovieLanguage: "es",
                          genreIDS: [18, 878, 53])
        
        let movieData = try JSONEncoder().encode(movie)
        let decodedMovie = try JSONDecoder().decode(Movie.self, from: movieData) as Movie
        
        XCTAssertEqual(movie, decodedMovie)
    }
    
//    func testMoviesCloudManager() {
//        MoviesCloudManager.shared.fetchMovies { (response: MoviesResponse?, error: Error?) in
//            if let moviesResponse = response {
//                XCTAssertEqual(moviesResponse.movies.count, 20)
//            }
//        }
//    }
    
}
