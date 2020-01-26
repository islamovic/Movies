//
//  Image.swift
//  Movies
//
//  Created by Islam on 1/26/20.
//  Copyright © 2020 App Lineup. All rights reserved.
//

import Foundation

class Photos: Decodable {
    let photos: PhotoModel
}

class PhotoModel: Decodable {
    let photo: [Photo]
}

class Photo: Decodable {
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
}
