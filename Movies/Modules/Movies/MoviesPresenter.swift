//
//  MoviesPresenter.swift
//  Movies
//
//  Created by Islam on 1/23/20.
//  Copyright © 2020 App Lineup. All rights reserved.
//

import Foundation

class MoviesScenePresenter: MoviesScenePresentingLogic {

    // MARK: Stored Properties
    weak var displayView: MoviesSceneDisplayView?

    // MARK: Initializers
    required init(displayView: MoviesSceneDisplayView) {
        self.displayView = displayView
    }
}

extension MoviesScenePresenter {

    func presentFetchedMovies(_ response: MoviesScene.Fetch.Response) {

        switch response {
            case .success(let movies):
                let viewModel = movies.map {
                    MoviesScene.ViewModel(title: $0.title)
                }
                displayView?.display(movies: viewModel)
            case .error(let error):
                displayView?.display(error: error)
        }
    }
}
