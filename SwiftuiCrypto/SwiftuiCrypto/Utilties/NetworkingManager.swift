//
//  NetworkingManager.swift
//  SwiftuiCrypto
//
//  Created by KSH on 12/4/23.
//

import Foundation
import Combine

class NetworkingManager {
    
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url): return "[🔥] Bad response URL. \(url)"
            case .unknown: return "[⚠️] Unknown error occured"
            }
        }
    }
    
    static func download(url: URL) -> AnyPublisher<Data, any Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
        // subscribe - 네트워크 요청을 수행할 큐를 설정하는 메서드
            .subscribe(on: DispatchQueue.global())
            .tryMap({ try handleURLResponse(output: $0, url: url) })
        // receive - 메인 큐에서 수행되도록 설정하는 메서드
            .receive(on: DispatchQueue.main)
        // eraseToAnyPublisher - 특정 Publisher 유형을 지우고, 제네릭 유형이 필요한 코드에서 유연하게 처리해주는 메서드
        // Publishers.ReceiveOn<Publishers.TryMap<Publishers.SubscribeOn<URLSession.DataTaskPublisher, DispatchQueue>, Data>, DispatchQueue> 이게 원래 반환 메서드인데
        // eraseToAnyPublisher 메서드를 사용함으로 AnyPublisher<Data, any Error>으로 줄여짐
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: url)
        }
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
