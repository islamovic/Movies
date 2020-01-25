//
//  MovieInfoViewController.swift
//  Movies
//
//  Created by Islam on 1/25/20.
//  Copyright © 2020 App Lineup. All rights reserved.
//

import UIKit

class MovieInfoViewController: UIViewController {

    @IBOutlet var movieInfoTableView: UITableView!

    var interactor: MovieInfoSceneBusinessLogic!
    var dataStore: MovieInfoSceneDataStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
//        movieInfoTableView.reloadData()
    }
}

extension MovieInfoViewController: MovieInfoSceneDisplayView {

    func display(movies: [MovieInfoScene.ViewModel]) {

    }

    func display(error: CustomError) {

    }
}

extension MovieInfoViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: MovieInfoCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MovieInfoCell
        cell.configure(movie: dataStore.movie)
        return cell
    }
}

private extension MovieInfoViewController {
    func setup() {
        setupTableView()
        self.title = "Info"
    }

    func setupTableView() {

        movieInfoTableView.rowHeight = UITableView.automaticDimension
        movieInfoTableView.estimatedRowHeight = 48

        let identifier = String(describing: MovieInfoCell.self)
        let nib = UINib(nibName: identifier, bundle: nil)
        movieInfoTableView.register(nib, forCellReuseIdentifier: identifier)

        movieInfoTableView.dataSource = self

        movieInfoTableView.tableFooterView = UIView(frame: .zero)
    }

}
