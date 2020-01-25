//
//  MovieInfoConfigurator.swift
//  Movies
//
//  Created by Islam on 1/25/20.
//  Copyright © 2020 App Lineup. All rights reserved.
//

import Foundation

class MovieInfoSceneConfigurator {

    static func configure() -> MovieInfoViewController {

        let viewController = MovieInfoViewController()
        let presenter = MovieInfoScenePresenter(displayView: viewController)
        let interactor = MovieInfoSceneInteractor(presenter: presenter)
        viewController.interactor = interactor
        viewController.dataStore = interactor
        return viewController
    }

}
