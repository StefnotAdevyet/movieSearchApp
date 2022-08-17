//
//  SearchTableCell.swift
//  MovieSearch
//
//  Created by developer on 8/16/22.
//

import UIKit

class SearchTableCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    class var id: String { String(describing: self) }
    class var nib: UINib { UINib(nibName: id, bundle: nil) }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
    
}
