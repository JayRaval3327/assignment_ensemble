//
//  ResultState.swift
//  assignment_ensemble
//
//  Created by Jay Raval on 2024-05-09.
//

import Foundation

public enum ResultState<T, E: Error> {
    case waiting
    case loading(T?)
    case found(T)
    case failed(E)
}

extension ResultState {
    var value: T? {
        switch self {
        case .loading(let items):
            return items
        case .found(let items):
            return items
        default:
            return nil
        }
    }
    static func fromResult(result: Result<T, E>) -> ResultState<T, E> {
        switch result {
        case .failure(let error):
            return .failed(error)
        case .success(let value):
            return .found(value)
        }
    }
}
