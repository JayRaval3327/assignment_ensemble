//
//  NetworkError.swift
//  assignment_ensemble
//
//  Created by Jay Raval on 2024-05-08.
//

import Foundation

enum NetworkError: Error {
    case invalidURL(url: URL?)
    case customError(description: String)
    case responseUnsuccessful(codeError: Int)
    case noResponse
    case responseNotDecoded
    case unknown
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .invalidURL(url):
            return "URL is not valid: \(String(describing: url))"
        case let .customError(description):
            return description
        case let .responseUnsuccessful(codeError):
            return "Response failed \(codeError)"
        case .noResponse:
            return "No Data Received"
        case .responseNotDecoded:
            return "Data cannot be decoded"
        case .unknown:
            return "Unknown Error"
        }
    }
}
