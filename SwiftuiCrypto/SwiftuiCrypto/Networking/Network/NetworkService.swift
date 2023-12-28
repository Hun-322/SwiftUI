//
//  NetworkingManager.swift
//  SwiftuiCrypto
//
//  Created by KSH on 12/4/23.
//

import Foundation
import Combine

// URLSession을 의존성 주입을 하는 이유
// 네트워크 통신이 되지 않는 환경에서도 나머지 데이터를 처리하는 로직이 잘 작동하는지 테스트할 수 있는 코드를 만들 수 있음.
// 네트워크 통신이 안되더라도 (data, response, error의 처리에 대한)나머지 로직이 잘 굴러가는지 확인해보기위해서(Test할때 MockURLSession을 넣어서 실험 가능)
// dataTask(dataTaskPublisher) 작업을 가로채는 것!! 을 강조 한 부분 기본 URLSession 동작을 하는 class를 만드는 dataTask 메소드를 통해 session의 dataTask 메소드를 호출해 사용한다.
// URLSession의 네트워크 동작이 어떻게 동작하던 dataTask를 선언한 메소드의 데이터 흐름을 제어한다면 언제든지 네트워크와 무관한 모델 테스트가 가능해져서 의존성 주입을 한다.
protocol URLSessionProtocol {
    func dataTaskPublisher(for request: URLRequest) -> URLSession.DataTaskPublisher
}

extension URLSession: URLSessionProtocol {}

protocol NetworkServable {
    func request<API>(_ api: API) -> AnyPublisher<API.Response, NetworkError> where API: ServableAPI
    func imageDownload(url: URL) -> AnyPublisher<Data, NetworkError>
    func handleCompletion(completion: Subscribers.Completion<NetworkError>)
}

class NetworkService: NetworkServable {
    let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func request<API>(
        _ api: API
    ) -> AnyPublisher<API.Response, NetworkError>
    where API: ServableAPI {
        return session.dataTaskPublisher(for: api.urlRequest)
            .tryMap { data, response in
                try self.validate(response)
                return data
            }
            .decode(type: API.Response.self, decoder: JSONDecoder())
            .mapError{ self.convertNetworkError(from: $0) }
            .eraseToAnyPublisher()
    }
    
    func imageDownload(url: URL) -> AnyPublisher<Data, NetworkError> {
        let urlRequest = URLRequest(url: url)
        return session.dataTaskPublisher(for: urlRequest)
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
            print("네트워크 request 실패 오류입니다! \(error.localizedDescription)")
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
