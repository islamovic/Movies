//
//  MovieInfoInteractor.swift
//  Movies
//
//  Created by Islam on 1/25/20.
//  Copyright © 2020 App Lineup. All rights reserved.
//

import Foundation

class MovieInfoSceneInteractor: MovieInfoSceneBusinessLogic, MovieInfoSceneDataStore {

    // MARK: Stored Properties
    let presenter: MovieInfoScenePresentingLogic

    var movie = Movie()

    // MARK: Initializers
    required init(presenter: MovieInfoScenePresentingLogic) {
        self.presenter = presenter
    }
}
