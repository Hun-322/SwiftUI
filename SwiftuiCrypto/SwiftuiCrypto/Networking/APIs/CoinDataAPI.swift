//
//  CoinDataAPI.swift
//  SwiftuiCrypto
//
//  Created by KSH on 12/25/23.
//

import Foundation

struct CoinDataAPI: ServableAPI {
    typealias Response = CoinModel
    
    var vsCurrency: String
    var order: String 
    var perPage: String
    var page: String
    var sparkline: Bool
    var priceChangePercentage: String
    var locale: String
    
    var path: String { "coins/markets" }
    var params: [String : String] {
        [
            "vs_currency": vsCurrency,
            "order": order,
            "per_page": perPage,
            "sparkline": String(sparkline),
            "price_change_percentage": priceChangePercentage,
            "locale": locale
        ]
    }
}
