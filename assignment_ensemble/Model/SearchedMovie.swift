//
//  SearchedMovie.swift
//  assignment_ensemble
//
//  Created by Jay Raval on 2024-05-08.
//

import Foundation

typealias Movies = [Movie]

struct SearchedMovie: Decodable {
    let search: Movies
    let totalResults: String
    let response: String
    
    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }
}

struct Movie: Decodable {
    let title, year, imdbID: String
    let type: String
    let poster: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case type = "Type"
        case poster = "Poster"
        case imdbID
    }
}

enum MovieType: String, Decodable {
    case game
    case movie
}
