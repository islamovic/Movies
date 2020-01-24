//
//  CustomError.swift
//  Movies
//
//  Created by Islam on 1/23/20.
//  Copyright © 2020 App Lineup. All rights reserved.
//

import Foundation

enum CustomError: Error {
    case
    custom(String)

    var localizedDescription: String {
        switch self {
        case .custom(let message): return message
        }
    }

}
