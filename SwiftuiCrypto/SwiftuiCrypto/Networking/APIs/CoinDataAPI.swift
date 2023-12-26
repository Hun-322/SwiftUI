//
//  CoinDataAPI.swift
//  SwiftuiCrypto
//
//  Created by KSH on 12/25/23.
//

import Foundation

struct CoinDataAPI: ServableAPI {
    typealias Response = [CoinModel]
    
    var vsCurrency: String = "krw"
    var order: String = "market_cap_desc"
    var perPage: String = "250"
    var page: String = "1"
    var sparkline: Bool = true
    var priceChangePercentage: String = "24h"
    var locale: String = "ko"
    
//    init(vsCurrency: String, order: String, perPage: String, page: String, sparkline: Bool, priceChangePercentage: String, locale: String) {
//        self.vsCurrency = vsCurrency
//        self.order = order
//        self.perPage = perPage
//        self.page = page
//        self.sparkline = sparkline
//        self.priceChangePercentage = priceChangePercentage
//        self.locale = locale
//    }
    
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
