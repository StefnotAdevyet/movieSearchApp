//
//  TableViewCell.swift
//  MovieBrowser
//
//  Created by developer on 6/11/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import UIKit
import Foundation

class MovieCell: UITableViewCell {

    
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(movie: Movie) {
        movieTitleLabel.text = movie.original_title
        releaseDateLabel.text = setDate(date: movie.release_date)
        ratingLabel.text = String(movie.vote_average)
    }
    
    func setDate(date: String) -> String {
        let months: [String] = [
        "January",
        "February",
        "March",
        "April",
        "May",
        "June",
        "July",
        "August",
        "September",
        "October",
        "November",
        "December"
        ]
        
        let digits = date.components(separatedBy: "-")
        let year = digits[0]
        let month = Int(digits[1])! - 1
        let day = digits[2]

        return "\(months[month]) \(day), \(year)"
    }
    
    
}
