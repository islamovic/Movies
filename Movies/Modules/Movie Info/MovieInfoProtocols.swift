//
//  MovieInfoProtocols.swift
//  Movies
//
//  Created by Islam on 1/25/20.
//  Copyright © 2020 App Lineup. All rights reserved.
//

import Foundation

// MARK: - View
protocol MovieInfoSceneDisplayView: class {
    func display(movies: [MovieInfoScene.ViewModel])
    func display(error: CustomError)
}

// MARK: - Interactor
protocol MovieInfoSceneBusinessLogic: class {
//    func fetchMovieInfo()
//    func filterMovies(_ request: MovieInfoScene.Filter.Request)
}

// MARK: - Presenter
protocol MovieInfoScenePresentingLogic: class {
//    func presentFetchedMovies(_ response: MovieInfoScene.Fetch.Response)
}

// MARK: - Data Store
protocol MovieInfoSceneDataStore: class {
    var movie: Movie { get set }
}

// MARK: - Functionalities
enum MovieInfoScene {
    struct ViewModel {
        let title: String
        let year: Int
        let cast: [String]
        let genres: [String]
        let rating: Int
    }
}

extension MovieInfoScene {
    enum Fetch {}
}

extension MovieInfoScene.Fetch {
    typealias Response = Result<Movie, CustomError>
}
