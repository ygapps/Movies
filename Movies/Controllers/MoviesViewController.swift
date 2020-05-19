//
//  ViewController.swift
//  Movies
//
//  Created by Youssef on 5/18/20.
//  Copyright © 2020 Instabug. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        MoviesCloudManager.shared.fetchMovies { (moviesResponse, error) in
            
        }
    }


}

