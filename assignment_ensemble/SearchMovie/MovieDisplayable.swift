//
//  MovieDisplayable.swift
//  assignment_ensemble
//
//  Created by Jay Raval on 2024-05-09.
//

import Foundation
import SwiftUI

typealias MovieDisplayables = [MovieDisplayable]

struct MovieDisplayable: Identifiable {
    let id: String
    var title: String
    var imageURL: String
    var yearOfRelease: String
    
    init(title: String, imageURL: String, yearOfRelease: String) {
        self.id = UUID().uuidString
        self.title = title
        self.imageURL = imageURL
        self.yearOfRelease = yearOfRelease
    }
}

extension MovieDisplayable {
    init(_ movie: Movie){
        self.init(title: movie.title,
                  imageURL: movie.poster,
                  yearOfRelease: movie.year)
    }
}

extension Array where Element == MovieDisplayable {
    static var loading: Self {
        return (1...10).map { _ in
            MovieDisplayable(title: "loading",
                             imageURL: "",
                             yearOfRelease: "2024")
        }
    }
}
