//
//  MoviesViewController.swift
//  Movies
//
//  Created by Islam on 1/24/20.
//  Copyright © 2020 App Lineup. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {

    var interactor: MoviesSceneBusinessLogic!

    override func viewDidLoad() {
        super.viewDidLoad()

        interactor.fetchMovies()
    }
}

extension MoviesViewController: MoviesSceneDisplayView {

    func display(movies: [MoviesScene.ViewModel]) {

    }

    func display(error: CustomError) {
        
    }
}
