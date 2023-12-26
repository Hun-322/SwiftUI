//
//  CoinImageDownloadAPI.swift
//  SwiftuiCrypto
//
//  Created by KSH on 12/26/23.
//

import Foundation

struct CoinImageDownloadAPI: ServableAPI {
    typealias Response = String
    
    var path: String { "global" }
    var params: [String : String] {
        [:]
    }
}
