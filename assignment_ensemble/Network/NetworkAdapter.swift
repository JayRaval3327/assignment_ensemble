//
//  NetworkAdapter.swift
//  assignment_ensemble
//
//  Created by Jay Raval on 2024-05-08.
//

import Foundation
import Combine

protocol Networkable {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async throws -> T
}

class NetworkAdapter: Networkable {
    
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async throws -> T {
            
        let stringURL = endpoint.baseURL.appending(endpoint.path)
        
        guard let url = URL(string: stringURL) else {
            throw NetworkError.invalidURL(url: URL(string: stringURL))
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers
        
        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        
        let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.noResponse
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            guard let decodedResponse = try? JSONDecoder().decode(responseModel, from: data) else {
                throw NetworkError.responseNotDecoded
            }
            return decodedResponse
            
        default:
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any], 
                let errorDescription = json["Error"] as? String {
                throw NetworkError.customError(description: errorDescription)
            }
            throw NetworkError.responseUnsuccessful(codeError: httpResponse.statusCode)
        }
    }
    
}
