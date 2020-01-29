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
    var movies: [Movie]
    var searchEnabled: Bool = false
    var searchResults: [[Int : [Movie]]] = []

    // MARK: Initializers
    required init(presenter: MoviesScenePresentingLogic) {
        self.presenter = presenter
        movies = []
    }
}

extension MoviesSceneInteractor {
    func fetchMovies() {

        if !movies.isEmpty {
            let response = MoviesScene.Fetch.Response.success(movies)
            self.presenter.presentFetchedMovies(response)
            return
        }
        worker.fetchMovies { [weak self] (movies, error) in

            guard let `self` = self else { return }

            if let error = error {
                let response = MoviesScene.Fetch.Response.error(error)
                self.presenter.presentFetchedMovies(response)
            } else {
                self.movies = movies.sorted { $0.year > $1.year }
                let response = MoviesScene.Fetch.Response.success(self.movies)
                self.presenter.presentFetchedMovies(response)
            }
        }
    }

    func filterMovies(_ request: MoviesScene.Filter.Request) {

        var filteredMovies = [Movie]()

        filteredMovies = movies.filter { $0.title.lowercased().contains(request.query.lowercased()) ||
            String(describing: $0.year).contains(request.query) }.sorted { $0.rating > $1.rating }

        let grouped = Dictionary(grouping: filteredMovies, by: { $0.year })

        var results: [ [Int: [Movie]] ] = []

        grouped.forEach { (key, value) in
            results.append([key: Array(value.prefix(5))])
        }

        let response = MoviesScene.Filter.Response.success(results)
        presenter.presentFetchedSearchMovies(response)
    }
}
