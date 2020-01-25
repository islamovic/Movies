//
//  MovieInfoCell.swift
//  Movies
//
//  Created by Islam on 1/25/20.
//  Copyright © 2020 App Lineup. All rights reserved.
//

import UIKit

class MovieInfoCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var castLabel: UILabel!
    @IBOutlet var genresLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(movie: Movie) {
        titleLabel.text = movie.title
        yearLabel.text = "\(movie.year)"
        ratingLabel.text = "\(movie.rating)/5"
        castLabel.text = movie.cast.joined(separator: ", ")
        genresLabel.text = movie.genres.joined(separator: ", ")
    }
    
}
