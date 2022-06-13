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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(movie: Movie) {
        guard let date = formatDate(dateString: movie.release_date, outFormat: "MMMM dd, yyyy") else { return }
        movieTitleLabel.text = movie.original_title
        releaseDateLabel.text = date
        ratingLabel.text = String(movie.vote_average)
    }
    
    func formatDate(dateString: String, inFormat: String = "yyyy/MM/dd", outFormat: String) -> String? {
        let dateFormatter = DateFormatter.posixFormatter
        dateFormatter.dateFormat = inFormat
        guard let date = dateFormatter.date(from: dateString) else { return nil }
        dateFormatter.dateFormat = outFormat
        return dateFormatter.string(from: date)
    }
}


