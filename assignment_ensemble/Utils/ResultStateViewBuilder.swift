//
//  ResultStateViewBuilder.swift
//  assignment_ensemble
//
//  Created by Jay Raval on 2024-05-09.
//

import Foundation
import SwiftUI
import Combine

final class ResultStateViewBuilder<T, E: Error> {
    
    private let result: ResultState<T, E>
    private var loading: ((T?) -> AnyView)?
    private var waiting: (() -> AnyView)?
    
    init(result: ResultState<T, E>) {
        self.result = result
    }
    
    @ViewBuilder
    func buildContent<Content: View>(@ViewBuilder _ content: (T) -> Content) -> some View {
        self.buildDefaultView(content)
    }

    @ViewBuilder
    private func buildDefaultView<Content: View>(@ViewBuilder _ content: (T) -> Content) -> some View {
        switch self.result {
        case .waiting:
            if let waiting = self.waiting {
                waiting()
            } else {
                StandardProgressView()
            }
        case .loading(let data):
            if let loadingView = self.loading {
                loadingView(data)
                    .redacted(reason: .placeholder)
            } else {
                StandardProgressView()
            }
        case .found(let data):
            content(data)
        case .failed(let error):
            if let errorDisplayable = error as? ErrorDisplayable {
                StandardEmptyView(error: errorDisplayable)
            } else {
                StandardEmptyView(message: "Something Went Wrong!")
            }
        }
    }
}

extension ResultStateViewBuilder {
    func setWaitingView<Waiting: View>(@ViewBuilder _ waiting: @escaping () -> Waiting) -> Self {
        self.waiting = { AnyView(waiting()) }
        return self
    }
    
    func setLoadingView<Loading: View>(@ViewBuilder _ loading: @escaping (T?) -> Loading) -> Self {
        self.loading = { AnyView(loading($0)) }
        return self
    }
}
