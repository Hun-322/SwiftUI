//
//  CoinDetailAPI.swift
//  SwiftuiCrypto
//
//  Created by KSH on 12/26/23.
//

import Foundation

struct CoinDetailAPI: ServableAPI {
    typealias Response = CoinDetailModel
    
    var id: String
    var localization: Bool = false
    var tickers: Bool = false
    var marketData: Bool = false
    var communityData: Bool = false
    var developerData: Bool = false
    var sparkline: Bool = false
    
    init(id: String) {
        self.id = id
    }
    
    var path: String { "coins" }
    var params: [String : String] {
        [
            "id": id,
            "localization": String(localization),
            "tickers": String(tickers),
            "market_data": String(marketData),
            "community_data": String(communityData),
            "developer_data": String(developerData),
            "sparkline": String(sparkline)
        ]
    }
    
    
}
