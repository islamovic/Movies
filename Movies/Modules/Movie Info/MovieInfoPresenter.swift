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

}
