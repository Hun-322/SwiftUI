//
//  CoinDataAPI.swift
//  SwiftuiCrypto
//
//  Created by KSH on 12/25/23.
//

import Foundation

struct CoinDataAPI: ServableAPI {
    typealias Response = [CoinModel]
    
    private var vsCurrency: String
    private var order: String
    private var perPage: String
    private var page: String
    private var sparkline: Bool
    private var priceChangePercentage: String
    private var locale: String
    
    init(vsCurrency: String, order: String, perPage: String = "250", page: String = "1", sparkline: Bool = true, priceChangePercentage: String, locale: String = "ko") {
        self.vsCurrency = vsCurrency
        self.order = order
        self.perPage = perPage
        self.page = page
        self.sparkline = sparkline
        self.priceChangePercentage = priceChangePercentage
        self.locale = locale
    }
    
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
