//
//  MoviesProtocols.swift
//  Movies
//
//  Created by Islam on 1/23/20.
//  Copyright © 2020 App Lineup. All rights reserved.
//

import UIKit

// MARK: - View
protocol MoviesSceneDisplayView: class {
    func display(viewModel: MoviesScene.ViewModel)
    func display(filteredViewModel: MoviesScene.FilteredViewModel)
    func display(error: CustomError)
}

// MARK: - Interactor
protocol MoviesSceneBusinessLogic: class {
    func fetchMovies()
    func filterMovies(_ request: MoviesScene.Filter.Request)
}

// MARK: - Presenter
protocol MoviesScenePresentingLogic: class {
    func presentFetchedMovies(_ response: MoviesScene.Fetch.Response)
    func presentFetchedSearchMovies(_ response: MoviesScene.Filter.Response)
}

// MARK: - Router
protocol MoviesSceneRoutingLogic: class {
    var viewController: (MoviesSceneDisplayView & UIViewController)? { get set }
    var dataStore: MoviesSceneDataStore? { get set }

    func routeToMovieInfoScene(movie: Movie)
}

// MARK: - DataStore
protocol MoviesSceneDataStore: class {
    var movies: [Movie] { get set }
    var searchResults: [[Int: [Movie]]] { get set }
    var searchEnabled: Bool { get set }
}

// MARK: - Functionalities
enum MoviesScene {
    struct ViewModel {
        let movies: [Movie]
    }

    struct FilteredViewModel {
        let groupedMovies: [[Int: [Movie]]]
    }
}

extension MoviesScene {
    enum Fetch {}
    enum Filter {}
}

extension MoviesScene.Fetch {
    typealias Response = Result<[Movie], CustomError>
}

extension MoviesScene.Filter {
    struct Request {
        let query: String
    }

    typealias Response = Result<[[Int: [Movie]]], CustomError>
}
