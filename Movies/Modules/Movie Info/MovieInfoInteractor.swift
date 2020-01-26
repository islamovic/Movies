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
    var worker = MovieInfoWorker()

    var photos: [Photo] = []

    var movie = Movie()

    // MARK: Initializers
    required init(presenter: MovieInfoScenePresentingLogic) {
        self.presenter = presenter
    }
}

extension MovieInfoSceneInteractor {

    func fetchMoviePhotos(title: String) {
        worker.fetchMoviePhotos(title: title) { [weak self] (photos, error) in

            guard let `self` = self else { return }

            if let error = error {
                let response = MovieInfoScene.Fetch.Response.error(error)
                self.presenter.presentFetchedPhotos(response)
            } else {
                let response = MovieInfoScene.Fetch.Response.success(photos)
                self.presenter.presentFetchedPhotos(response)
            }
        }
    }
}
