//
//  SearchMovieViewModel.swift
//  assignment_ensemble
//
//  Created by Jay Raval on 2024-05-08.
//

import Foundation
import Combine

final class SearchMovieViewModel: ObservableObject {
    
    @Published
    private(set) var movies: ResultState<MovieDisplayables, ErrorDisplayable> = .waiting
    @Published
    var searchText: String = ""
    
    private var adapter: SearchMovieAdapter
    private var cancellables = Set<AnyCancellable>()
    var searchMovieTask: Task<Void, Never>?
    
    private enum Constants {
        static let minimumNumberOfCharacters = 2
    }
    
    init(adapter: SearchMovieAdapter) {
        self.adapter = adapter
    }
    
    func listenToSearchText() {
        self.$searchText
            .dropFirst()
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main) // If user is still typing don't search yet
            .handleEvents(receiveOutput: { [weak self] _ in // Start loading
                self?.movies = .loading(nil)
            })
            .receive(on: DispatchQueue.main)
            .sink { [weak self] searchTerm in
                self?.searchMovieIfNecessary(searchTerm) // Search
            }.store(in: &self.cancellables)
    }
    
    private func searchMovieIfNecessary(_ searchTerm: String) {
        let term = searchTerm.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if term.count < Constants.minimumNumberOfCharacters {
            self.movies = term.count == 0 ? .waiting : .loading(nil)
            // Handle the case where the text input is too short
        } else {
            searchMovieTask?.cancel()
            searchMovieTask = Task {
                let result = await adapter.searchMovie(term)
                DispatchQueue.main.async { self.movies = .fromResult(result: result) }
            }
        }
    }
    
}
