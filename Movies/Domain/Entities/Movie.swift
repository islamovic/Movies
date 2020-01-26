//
//  Movie.swift
//  Movies
//
//  Created by Islam on 1/23/20.
//  Copyright © 2020 App Lineup. All rights reserved.
//

import Foundation

struct Movies: Decodable {
    let movies: [Movie]
}

class Movie: Decodable {

    let title: String
    let year: Int
    let cast: [String]
    let genres: [String]
    let rating: Int

    init() {
        title = ""
        year = 0
        cast = []
        genres = []
        rating = 0
    }
}
