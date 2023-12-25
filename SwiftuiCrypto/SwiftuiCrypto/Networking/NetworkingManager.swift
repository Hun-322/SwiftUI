//
//  NetworkingManager.swift
//  SwiftuiCrypto
//
//  Created by KSH on 12/4/23.
//

import Foundation
import Combine

protocol Networkable {
    func request(url: URL) -> AnyPublisher<Data, NetworkError>
}

class NetworkingManager: Networkable {
        
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
    
    
    func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}

extension NetworkingManager {
    
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
