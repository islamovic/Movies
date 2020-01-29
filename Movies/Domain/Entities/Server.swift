//
//  Server.swift
//  Movies
//
//  Created by Islam on 1/25/20.
//  Copyright © 2020 App Lineup. All rights reserved.
//

import Foundation

public enum Server {
    
    public static var apiKey = "f4ebd41a8fb4c1ce3be515e2cdef233d"
    public static var baseURL = "https://api.flickr.com/services/rest/?method=flickr.photos.search"
}

extension Server {

    static func imagesRequest(input: String) -> String {

        let encodedTitle = input.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        return String("\(baseURL)&api_key=\(apiKey)&format=json&nojsoncallback=1&text=\(encodedTitle)")
    }

    static func photoRequest(photo: Photo) -> String {
        return "http://farm\(photo.farm).static.flickr.com/\(photo.server)/\(photo.id)_\(photo.secret).jpg"
    }
}
