//
//  CoinDetailAPI.swift
//  SwiftuiCrypto
//
//  Created by KSH on 12/26/23.
//

import Foundation

struct CoinDetailAPI: ServableAPI {
    typealias Response = CoinDetailModel
    
    private var id: String
    private var localization: Bool = false
    private var tickers: Bool = false
    private var marketData: Bool = false
    private var communityData: Bool = false
    private var developerData: Bool = false
    private var sparkline: Bool = false
    
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
