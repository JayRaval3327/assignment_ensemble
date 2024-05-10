//
//  Server.swift
//  assignment_ensemble
//
//  Created by Jay Raval on 2024-05-08.
//

import Foundation

struct Server {
    let urlString: String

    init(urlString: String) {
        self.urlString = urlString
    }
}

extension Server {
    static var selected: Server?
}

extension Server {
    static var selectedServer: Server {
        guard let server = Self.selected else {
            fatalError("You must set a selected server via `Server.selected`")
        }
        return server
    }
}

extension Server {
    static let omdb = Server(urlString: "https://omdbapi.com")
}
