//
//  ServableAPI.swift
//  SwiftuiCrypto
//
//  Created by KSH on 12/25/23.
//

import Foundation

protocol ServableAPI {
    associatedtype Response: Decodable
    var path: String { get }
    var params: [String: String] { get }
}

extension ServableAPI {
    var baseURL: String { "https://api.coingecko.com/api/v3/" }
    var urlRequest: URLRequest {
        var urlComponents = URLComponents(string: baseURL + path)!
        let queryItems = params.map { (key: String, value: String) in
            URLQueryItem(name: key, value: value)
        }
        urlComponents.queryItems = queryItems
        
        var request = URLRequest(url: urlComponents.url!)
        
        return request
    }
}
