//
//  MoviesConfigurator.swift
//  Movies
//
//  Created by Islam on 1/24/20.
//  Copyright © 2020 App Lineup. All rights reserved.
//

import Foundation

class MoviesSceneConfigurator {

    static func configure() -> MoviesViewController {

        let viewController = MoviesViewController()
        let presenter = MoviesScenePresenter(displayView: viewController)
        let interactor = MoviesSceneInteractor(presenter: presenter)
        let router = MoviesSceneRouter(viewController: viewController, dataStore: interactor)
        viewController.interactor = interactor
        viewController.dataStore = interactor
        viewController.router = router
        return viewController
    }

}
