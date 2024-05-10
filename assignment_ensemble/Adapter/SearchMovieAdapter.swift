//
//  SearchMovieAdapter.swift
//  assignment_ensemble
//
//  Created by Jay Raval on 2024-05-08.
//

import Foundation
import Combine

protocol SearchMovieAdapter {
    func searchMovie(_ term: String) async -> Result<MovieDisplayables, ErrorDisplayable>
}


extension NetworkAdapter: SearchMovieAdapter {
    
    func searchMovie(_ term: String) async -> Result<MovieDisplayables, ErrorDisplayable> {
        do {
            let result = try await self.sendRequest(endpoint: MovieEndpoint.search(term: term), responseModel: SearchedMovie.self)
            return .success(result.search.map({ .init($0) }))
        } catch {
            return .failure(ErrorDisplayable(error))
        }
    }

}
