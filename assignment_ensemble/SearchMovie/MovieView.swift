//
//  MovieView.swift
//  assignment_ensemble
//
//  Created by Jay Raval on 2024-05-09.
//

import Foundation
import SwiftUI

struct MovieView: View {
    
    @ObservedObject
    private var viewModel: SearchMovieViewModel
    
    init(viewModel: SearchMovieViewModel) {
        self.viewModel = viewModel
    }

    private enum Labels {
        static let waitingPlaceholder = "Search movie to get started"
    }
    
    var body: some View {
        NavigationStack {
            ResultStateViewBuilder(result: self.viewModel.movies)
                .setWaitingView {
                    StandardEmptyView(message: Labels.waitingPlaceholder)
                }
                .setLoadingView { displayable in
                    self.buildMoviesList(movies: displayable ?? .loading)
                }
                .buildContent(self.buildMoviesList)
            .onAppear { self.viewModel.listenToSearchText() }
            .navigationTitle("Movies")
        }
        .searchable(text: $viewModel.searchText)
    }
    
    @ViewBuilder
    private func buildMoviesList(movies: MovieDisplayables) -> some View {
        List {
            ForEach(movies.indices, id: \.self) { index in
                MovieItem(movie: movies[index])
            }
        }
    }
}
