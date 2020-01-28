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

    func display(viewModel: MoviesScene.ViewModel) {
        dataStore.searchEnabled = false
        activityIndicator.isHidden = true
        dataStore.movies = viewModel.movies
        moviesTableView.reloadData()
    }

    func display(error: CustomError) {
        dataStore.searchEnabled = false
        activityIndicator.isHidden = true
        showAlert(title: nil, message: error.localizedDescription)
    }

    func display(filteredViewModel: MoviesScene.FilteredViewModel) {
        dataStore.searchResults = filteredViewModel.groupedMovies
        dataStore.searchEnabled = true
        moviesTableView.reloadData()
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

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dataStore.searchEnabled = false
        interactor.fetchMovies()
    }
}

extension MoviesViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return dataStore.searchEnabled ? dataStore.searchResults.count : 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if dataStore.searchEnabled, let movies = dataStore.searchResults[section].values.first {
            return movies.count
        }
        return dataStore.movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let identifier = String(describing: MovieCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MovieCell
        var selectedMovie = Movie()

        if dataStore.searchEnabled, let movies = dataStore.searchResults[indexPath.section].values.first {
            selectedMovie = movies[indexPath.row]
        } else {
            selectedMovie = dataStore.movies[indexPath.row]
        }
        cell.configure(title: selectedMovie.title)
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if dataStore.searchEnabled, let _ = dataStore.searchResults[section].values.first {
            return String(dataStore.searchResults[section].keys.first!)
        }
        return ""
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return dataStore.searchEnabled ? 44 : 0.1
    }
}

extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
        if dataStore.searchEnabled, let movies = dataStore.searchResults[indexPath.section].values.first {
            delegate?.didSelectMovie(movies[indexPath.row])
        } else {
            delegate?.didSelectMovie(dataStore.movies[indexPath.row])
        }
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
