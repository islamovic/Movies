//
//  MovieInfoPresenter.swift
//  Movies
//
//  Created by Islam on 1/25/20.
//  Copyright © 2020 App Lineup. All rights reserved.
//

import Foundation

class MovieInfoScenePresenter: MovieInfoScenePresentingLogic {

    // MARK: Stored Properties
    weak var displayView: MovieInfoSceneDisplayView?

    // MARK: Initializers
    required init(displayView: MovieInfoSceneDisplayView) {
        self.displayView = displayView
    }
}

extension MovieInfoScenePresenter {
    func presentFetchedPhotos(_ response: MovieInfoScene.Fetch.Response) {

        switch response {
            case .success(let photos):
                let viewModel = MovieInfoScene.Fetch.ViewModel(photos: photos)
                displayView?.display(photos: viewModel)
            case .error(let error):
                displayView?.display(error: error)
        }
    }
}
