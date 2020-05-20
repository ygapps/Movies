//
//  Date+Formatter.swift
//  Movies
//
//  Created by Youssef on 5/20/20.
//  Copyright © 2020 Instabug. All rights reserved.
//

import Foundation

extension Date {
    var movieReleaseDateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, YYYY"
        
        return dateFormatter.string(from: self)
    }
}

extension String {
    var movieReleaseDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        return dateFormatter.date(from: self)
    }
}
