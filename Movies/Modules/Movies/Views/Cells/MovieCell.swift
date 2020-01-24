//
//  MovieCell.swift
//  Movies
//
//  Created by Islam on 1/25/20.
//  Copyright © 2020 App Lineup. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet var movieTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(title: String) {
        self.movieTitleLabel.text = title
    }
    
}
