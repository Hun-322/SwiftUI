//
//  MarketDataAPI.swift
//  SwiftuiCrypto
//
//  Created by KSH on 12/26/23.
//

import Foundation


struct MarketDataAPI: ServableAPI {
    typealias Response = GlobalData
    
    var path: String { "global" }
    var params: [String : String] {
        [:]
    }
}
