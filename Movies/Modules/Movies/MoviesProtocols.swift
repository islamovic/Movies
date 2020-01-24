//
//  MoviesProtocols.swift
//  Movies
//
//  Created by Islam on 1/23/20.
//  Copyright © 2020 App Lineup. All rights reserved.
//

import Foundation

// MARK: - View
protocol MoviesSceneDisplayView: class {
    func display(movies: [MoviesScene.ViewModel])
    func display(error: CustomError)
}

// MARK: - Interactor
protocol MoviesSceneBusinessLogic: class {
    func fetchMovies()
}

// MARK: - Presenter
protocol MoviesScenePresentingLogic: class {
    func presentFetchedMovies(_ response: MoviesScene.Fetch.Response)
}

// MARK: - DataStore
protocol MoviesSceneDataStore: class {
    var movies: [Movie] { get }
}

// MARK: -Functionalities
enum MoviesScene {
    struct ViewModel {
        let title: String
    }
}

extension MoviesScene {
    enum Fetch {}
}

extension MoviesScene.Fetch {
    typealias Response = Result<[Movie], CustomError>
}
