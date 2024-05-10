//
//  MovieItem.swift
//  assignment_ensemble
//
//  Created by Jay Raval on 2024-05-09.
//

import SwiftUI

struct MovieItem: View {
    
    private var movie: MovieDisplayable
    
    init(movie: MovieDisplayable) {
        self.movie = movie
    }
    
    private enum Labels {
        static let yearOfRelease = "Year of Release: "
        static let doNothingTitle = "Tap to do nothing"
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            buildImage()
            buildMovieInformation()
        }.padding([.bottom, .top])
    }
    
    @ViewBuilder
    private func buildImage() -> some View {
        if let photoURL = URL(string: movie.imageURL) {
            AsyncImage(url: photoURL) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } else if phase.error != nil {
                    Image(systemName: "questionmark.diamond")
                        .imageScale(.large)
                } else {
                    Rectangle()
                        .fill(.gray.opacity(0.5))
                }
            }
            .aspectRatio(contentMode: .fit)
            .frame(width: 130, height: 130)
        } else {
            Rectangle()
                .fill(.gray.opacity(0.5))
                .frame(width: 130, height: 130)
        }
    }
    
    @ViewBuilder
    private func buildMovieInformation() -> some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(verbatim: movie.title)
                .lineLimit(2)
            
            HStack(alignment: .top) {
                Text(Labels.yearOfRelease)
                Text(movie.yearOfRelease)
            }
            
            Button(action: {
                
            }, label: {
                Text(Labels.doNothingTitle)
            }).buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle)
            
            
        }
    }
}
