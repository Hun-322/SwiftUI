//
//  NetworkingManager.swift
//  SwiftuiCrypto
//
//  Created by KSH on 12/4/23.
//

import Foundation
import Combine

protocol NetworkServable {
    func request<API>(_ api: API) -> AnyPublisher<API.Response, NetworkError> where API: ServableAPI
    func request(url: URL) -> AnyPublisher<Data, NetworkError>
    func handleCompletion(completion: Subscribers.Completion<NetworkError>)
}

class NetworkService: NetworkServable {
        
    init() {}
    
    func request<API>(
        _ api: API
    ) -> AnyPublisher<API.Response, NetworkError>
    where API: ServableAPI {
        let session = URLSession.shared
        
        return session.dataTaskPublisher(for: api.urlRequest)
            .tryMap { data, response in
                try self.validate(response)
                return data
            }
            .decode(type: API.Response.self, decoder: JSONDecoder())
            .mapError{ self.convertNetworkError(from: $0) }
            .eraseToAnyPublisher()
    }
    
    func request(url: URL) -> AnyPublisher<Data, NetworkError> {
        let session = URLSession.shared
        
        return session.dataTaskPublisher(for: url)
            .tryMap { data, response in
                try self.validate(response)
                return data
            }
            .mapError{ self.convertNetworkError(from: $0) }
            .eraseToAnyPublisher()
    }

    
    
    func handleCompletion(completion: Subscribers.Completion<NetworkError>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}

extension NetworkService {
    
    private func validate(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.unknownError
        }
        
        switch httpResponse.statusCode {
        case 200..<300: return
        case 400..<500: throw NetworkError.clientError
        case 500..<600: throw NetworkError.serverError
        default: throw NetworkError.unknownError
        }
    }
    
    private func convertNetworkError(from error: Error) -> NetworkError {
        if let urlError = error as? URLError,
           urlError.code == .notConnectedToInternet {
            return NetworkError.disconnected
        } else {
            return NetworkError.apiIssue
        }
    }
}
