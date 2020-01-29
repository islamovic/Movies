//
//  SearchTest.swift
//  MoviesTests
//
//  Created by Islam on 1/29/20.
//  Copyright © 2020 App Lineup. All rights reserved.
//

import XCTest
@testable import Movies

class SearchTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearchQueryMission() {
        let presentSpy = PresenterSpy()
        let interactor = MoviesSceneInteractor(presenter: presentSpy)
        interactor.worker = Worker()

        let request = MoviesScene.Filter.Request(query: "mission")
        interactor.fetchMovies()
        interactor.filterMovies(request)

        let responsesMovies = presentSpy.fetchedSearchedMoviesResponse?.value ?? []
        XCTAssertEqual(responsesMovies.count, 2)
    }

    func testSearchQuery2012() {
        let presentSpy = PresenterSpy()
        let interactor = MoviesSceneInteractor(presenter: presentSpy)
        interactor.worker = Worker()

        let request = MoviesScene.Filter.Request(query: "2012")
        interactor.fetchMovies()
        interactor.filterMovies(request)

        let responsesMovies = presentSpy.fetchedSearchedMoviesResponse?.value ?? []
        XCTAssertEqual(responsesMovies.count, 2)
    }

    func testSearchQueryEmpty() {
        let presentSpy = PresenterSpy()
        let interactor = MoviesSceneInteractor(presenter: presentSpy)
        interactor.worker = Worker()

        let request = MoviesScene.Filter.Request(query: "testemptylist")
        interactor.fetchMovies()
        interactor.filterMovies(request)

        let responsesMovies = presentSpy.fetchedSearchedMoviesResponse?.value ?? []
        XCTAssertEqual(responsesMovies.count, 0)
    }

    func testSearchQueryCaseInsensitivity() {
        let presentSpy = PresenterSpy()
        let interactor = MoviesSceneInteractor(presenter: presentSpy)
        interactor.worker = Worker()

        interactor.fetchMovies()
        let requestlowerCase = MoviesScene.Filter.Request(query: "mission")
        interactor.filterMovies(requestlowerCase)
        let lowercaseMovieCount = presentSpy.fetchedSearchedMoviesResponse?.value?.count ?? 0

        let requestUpperCase = MoviesScene.Filter.Request(query: "MISSION")
        interactor.filterMovies(requestUpperCase)
        let uppercaseMovieCount = presentSpy.fetchedSearchedMoviesResponse?.value?.count ?? 0

        XCTAssertEqual(lowercaseMovieCount, uppercaseMovieCount)
    }

}

extension SearchTest {

    class PresenterSpy: MoviesScenePresentingLogic {
        var fetchedMoviesResponse: MoviesScene.Fetch.Response?
        var fetchedSearchedMoviesResponse: MoviesScene.Filter.Response?

        func presentFetchedMovies(_ response: MoviesScene.Fetch.Response) {
            fetchedMoviesResponse = response
        }

        func presentFetchedSearchMovies(_ response: MoviesScene.Filter.Response) {
            fetchedSearchedMoviesResponse = response
        }
    }

    class Worker: MovieWorker {

        override func fetchMovies(_ completionHandler: @escaping ([Movie], CustomError?) -> Void) {
            let movies = [Movie(title: "2012", year: 2009),
                          Movie(title: "(500) Days of Summer", year: 2009),
                          Movie(title: "12 Rounds", year: 2009),
                          Movie(title: "Dead Before Dawn", year: 2012),
                          Movie(title: "Dead Man's Burden", year: 2012),
                          Movie(title: "Admission", year: 2013),
                          Movie(title: "Gravity", year: 2013),
                          Movie(title: "The Green Inferno", year: 2013),
                          Movie(title: "Unfriended: Dark Web", year: 2018),
                          Movie(title: "Mission: Impossible – Fallout", year: 2018),
                          Movie(title: "Destroyer", year: 2018)]
            completionHandler(movies, nil)
        }
    }
}
