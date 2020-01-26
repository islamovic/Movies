//
//  MovieInfoWorker.swift
//  Movies
//
//  Created by Islam on 1/26/20.
//  Copyright © 2020 App Lineup. All rights reserved.
//

import Foundation

class MovieInfoWorker {

    func fetchMoviePhotos(title: String, _ completionHandler: @escaping([Photo], CustomError?) -> Void) {
        
        let encodedTitle = title.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        let string = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=f4ebd41a8fb4c1ce3be515e2cdef233d&format=json&nojsoncallback=1&text=\(encodedTitle)&page=1&perpage=10"

        let url = URL(string: string)!

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in

            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let photos = try decoder.decode(Photos.self, from: data)
                completionHandler(photos.photos.photo, nil)
            } catch let error {
                completionHandler([], CustomError.custom(error.localizedDescription))
            }
        }
        task.resume()
    }
}
