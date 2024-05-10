//
//  MovieEndpoint.swift
//  assignment_ensemble
//
//  Created by Jay Raval on 2024-05-08.
//

import Foundation

enum MovieEndpoint {
    case search(term: String)
}

extension MovieEndpoint: Endpoint {
    var path: String {
        switch self {
        case .search(let term):
            let encodedTerm = term.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            return "/?apikey=21bd5081&s=\(encodedTerm)"
        }
    }
    
    var method: HttpMethod {
        return .get
    }
}
