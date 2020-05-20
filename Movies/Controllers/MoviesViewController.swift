//
//  ViewController.swift
//  Movies
//
//  Created by Youssef on 5/18/20.
//  Copyright © 2020 Instabug. All rights reserved.
//

import UIKit

protocol Pagination: class {
    var recentLoadMoreTimestamp: TimeInterval {get set}
    
    var numberOfCells: Int {get set}
    var heightOfCell: CGFloat {get set}
    
    var isLoading: Bool {get set}

    func canLoadMore(_ scrollView: UIScrollView) -> Bool
    func loadMore(_ scrollView: UIScrollView)
}

class MoviesViewController: UIViewController {

    @IBOutlet weak var moviesTableView: UITableView!
    
    private(set) var moviesList: [Movie] = []
    private(set) var personalMoviesList: [PersonalMovie] = []
    
    var numberOfCells: Int = 2
    var heightOfCell: CGFloat = 330
    
    var recentLoadMoreTimestamp: TimeInterval = Date().timeIntervalSince1970
    var isLoading: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberOfCells = Int(UIScreen.main.bounds.height / heightOfCell)
        
        MoviesCloudManager.shared.fetchMovies { [weak self] (moviesResponse, error) in
            guard let self = self else { return }
            if let moviesResponse = moviesResponse {
                self.moviesList = moviesResponse.movies
                self.recentLoadMoreTimestamp = Date().timeIntervalSince1970
                DispatchQueue.main.async {
                    self.moviesTableView.reloadData()
                }
            }
        }
    }
}

// MARK: - MoviesTableView Datasource and Delegate


extension MoviesViewController: Pagination {
    
    func loadMore(_ scrollView: UIScrollView){
        if canLoadMore(scrollView) {
            if !isLoading {
                self.isLoading = true
                MoviesCloudManager.shared.fetchMovies(pageNumber: (self.moviesList.count / 20) + 1) { [weak self] (moviesResponse, error) in
                    guard let self = self else { return }
                    if let moviesResponse = moviesResponse {
                        self.moviesList.append(contentsOf: moviesResponse.movies)
                        DispatchQueue.main.async {
                            self.moviesTableView.reloadData()
                        }
                    }
                    self.isLoading = false
                }
            }
        }
    }
    
     func canLoadMore(_ scrollView: UIScrollView) -> Bool {
        let reachedBottom = scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height) - (heightOfCell * CGFloat(numberOfCells))
         let timeHasPassedSinceBottomReached = Date().timeIntervalSince1970 - recentLoadMoreTimestamp > 3
        return reachedBottom && timeHasPassedSinceBottomReached
    }
    
}

extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return personalMoviesList.count > 0 ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let lastSectionIndex = tableView.numberOfSections - 1
        if section == lastSectionIndex {
            return moviesList.count
        } else {
            return personalMoviesList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieCell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieCell
        
        movieCell.movieCardView.layer.cornerCurve = .continuous
        
        let lastSectionIndex = tableView.numberOfSections - 1
        if indexPath.section == lastSectionIndex {
            movieCell.movieTitleLabel.text = moviesList[indexPath.row].title
            movieCell.movieReleaseDateLabel.text = moviesList[indexPath.row].releaseDate.movieReleaseDate?.movieReleaseDateString
            movieCell.movieOverviewTextView.text = moviesList[indexPath.row].overview
            
            if let posterURL = moviesList[indexPath.row].posterImageURL() {
                movieCell.moviePosterImageView.setMoviePoster(withURL: posterURL)
            }
        } else {
            
            movieCell.movieReleaseDateLabel.text = personalMoviesList[indexPath.row].movieReleaseDate.movieReleaseDateString
            movieCell.movieTitleLabel.text = personalMoviesList[indexPath.row].movieTitle
            movieCell.movieOverviewTextView.text = personalMoviesList[indexPath.row].movieOverview
            movieCell.moviePosterImageView.image = personalMoviesList[indexPath.row].posterImage
        }
        
        return movieCell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let lastSectionIndex = tableView.numberOfSections - 1
        if section == lastSectionIndex {
            return "All Movies"
        } else {
            return "My Movies"
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightOfCell
    }
    
     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            let spinner = UIActivityIndicatorView(style: .large)
            spinner.startAnimating()
            spinner.color = UIColor.systemYellow
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            
            tableView.tableFooterView = spinner
            tableView.tableFooterView?.isHidden = false
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        loadMore(scrollView)
    }
}

// MARK: - AddMovieViewControllerDelegate

extension MoviesViewController: AddMovieViewControllerDelegate {
    func addMovieViewController(_ addMovieViewController: AddMovieViewController, didAddPersonalMovie personalMovie: PersonalMovie) {
        self.personalMoviesList.append(personalMovie)
        self.moviesTableView.reloadData()
        self.moviesTableView.setContentOffset(CGPoint.zero, animated: true)
    }
}
