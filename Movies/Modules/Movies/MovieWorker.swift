//
//  MovieWorker.swift
//  Movies
//
//  Created by Islam on 1/24/20.
//  Copyright © 2020 App Lineup. All rights reserved.
//

import Foundation

class MovieWorker {

    func fetchMovies(_ completionHandler: @escaping([Movie], CustomError?) -> Void) {

        if let url = Bundle.main.url(forResource: "movies", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let movies = try decoder.decode(Movies.self, from: data)
                completionHandler(movies.movies, nil)
            } catch let error {
                completionHandler([], CustomError.custom(error.localizedDescription))
            }
        } else {
            completionHandler([], CustomError.custom("Could not load movies"))
        }
    }
}
