//
//  MovieCell.swift
//  Movies
//
//  Created by Youssef on 5/19/20.
//  Copyright © 2020 Instabug. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieReleaseDateLabel: UILabel!
    @IBOutlet weak var movieOverviewTextView: UITextView!
    @IBOutlet weak var movieCardView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
