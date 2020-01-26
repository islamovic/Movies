//
//  MoviesViewController.swift
//  Movies
//
//  Created by Islam on 1/24/20.
//  Copyright © 2020 App Lineup. All rights reserved.
//

import UIKit

protocol MoviesDelegate: class {
    func didSelectMovie(_ movie: Movie)
}

class MoviesViewController: UIViewController {

    @IBOutlet var moviesTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    let searchController = UISearchController(searchResultsController: nil)
    
    var interactor: MoviesSceneBusinessLogic!
    var dataStore: MoviesSceneDataStore!
    var router: MoviesSceneRouter!

    weak var delegate: MoviesDelegate?

    var dataSource = [MoviesScene.ViewModel]() {
        didSet {
            moviesTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        activityIndicator.isHidden = false
        DispatchQueue.main.async { [weak self] in
            self?.interactor.fetchMovies()
        }
    }
}

extension MoviesViewController: MoviesSceneDisplayView {

    func display(movies: [MoviesScene.ViewModel]) {
        activityIndicator.isHidden = true
        dataSource = movies
        dataStore.movies = dataSource.map { $0.movie }
    }

    func display(error: CustomError) {
        activityIndicator.isHidden = true
        showAlert(title: nil, message: error.localizedDescription)
    }
}

extension MoviesViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let keyword = searchBar.text, !keyword.isEmpty {
            interactor.filterMovies(MoviesScene.Filter.Request(query: keyword))
        } else {
            interactor.fetchMovies()
        }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        interactor.filterMovies(MoviesScene.Filter.Request(query: searchText))
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        interactor.filterMovies(MoviesScene.Filter.Request(query: searchBar.text ?? ""))
    }
}

extension MoviesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: MovieCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MovieCell
        let selectedMovie = dataSource[indexPath.row]
        cell.configure(title: selectedMovie.movie.title)
        return cell
    }
}

extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didSelectMovie(dataStore.movies[indexPath.row])
        if let infoViewController = delegate as? MovieInfoViewController,
            let infoNavigationController = infoViewController.navigationController {
            splitViewController?.showDetailViewController(infoNavigationController, sender: nil)
        }
    }
}


private extension MoviesViewController {

    func setup() {
        setupTableView()
        setupSearchController()
        self.title = "Movies"
    }

    func setupTableView() {

        moviesTableView.rowHeight = UITableView.automaticDimension
        moviesTableView.estimatedRowHeight = 48

        let identifier = String(describing: MovieCell.self)
        let nib = UINib(nibName: identifier, bundle: nil)
        moviesTableView.register(nib, forCellReuseIdentifier: identifier)

        moviesTableView.dataSource = self
        moviesTableView.delegate = self

        moviesTableView.tableFooterView = UIView(frame: .zero)
    }

    func setupSearchController() {
        searchController.searchBar.placeholder = "Search for a movie by year"
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            moviesTableView.tableHeaderView = searchController.searchBar
        }

        searchController.searchBar.delegate = self
        definesPresentationContext = true
        searchController.obscuresBackgroundDuringPresentation = false
    }
}
