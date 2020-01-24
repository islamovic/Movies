//
//  MoviesInteractor.swift
//  Movies
//
//  Created by Islam on 1/23/20.
//  Copyright © 2020 App Lineup. All rights reserved.
//

import Foundation

class MoviesSceneInteractor: MoviesSceneBusinessLogic, MoviesSceneDataStore {

    // MARK: Stored Properties
    let presenter: MoviesScenePresentingLogic
    var worker = MovieWorker()

    // MARK: Data Store
    var movies: [Movie] = []

    // MARK: Initializers
    required init(presenter: MoviesScenePresentingLogic) {
        self.presenter = presenter
    }
}

extension MoviesSceneInteractor {
    func fetchMovies() {

        worker.fetchMovies { [weak self] (movies, error) in

            guard let `self` = self else { return }

            if let error = error {
                let response = MoviesScene.Fetch.Response.error(error)
                self.presenter.presentFetchedMovies(response)
            } else {
                let sortedMovies = movies.sorted { $0.year > $1.year }
                let response = MoviesScene.Fetch.Response.success(sortedMovies)
                self.presenter.presentFetchedMovies(response)
            }
        }
    }
}
