//
//  CoinModel.swift
//  SwiftuiCrypto
//
//  Created by KSH on 12/1/23.
//

import Foundation

/*
 https://api.coingecko.com/api/v3/coins/markets?vs_currency=krw&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h&locale=ko
 
 {
     "id": "bitcoin",
     "symbol": "btc",
     "name": "비트코인",
     "image": "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
     "current_price": 50350334,
     "market_cap": 984665149349653,
     "market_cap_rank": 1,
     "fully_diluted_valuation": 1057267669895283,
     "total_volume": 28144718280107,
     "high_24h": 50537149,
     "low_24h": 48752322,
     "price_change_24h": 1285582,
     "price_change_percentage_24h": 2.62018,
     "market_cap_change_24h": 25574813505433,
     "market_cap_change_percentage_24h": 2.66657,
     "circulating_supply": 19557931,
     "total_supply": 21000000,
     "max_supply": 21000000,
     "ath": 81339064,
     "ath_change_percentage": -38.10792,
     "ath_date": "2021-11-10T14:24:11.849Z",
     "atl": 75594,
     "atl_change_percentage": 66495.9864,
     "atl_date": "2013-07-05T00:00:00.000Z",
     "roi": null,
     "last_updated": "2023-12-01T11:32:36.477Z",
     "sparkline_in_7d": {
       "price": [
         37395.90827506792,
         37379.467490416195,
         37496.92132716386,
         37436.84535484026,
         37625.47515761646,
         37637.81821990924,
         37799.85874760194,
         37721.27737308314,
         37779.131729484536,
         37804.55731133284,
         38189.655829505544,
         37758.103819696225,
         37834.992480078836,
         37705.00717642783,
         37800.85326928097,
         37879.28207334728,
         37841.92561759012,
         37757.677579908384,
         37738.93169747125,
         37736.54681030877,
         37803.52427387762,
         37827.27932705619,
         37804.76647832383,
         37801.38886126128,
         37820.24727366895,
         37806.05244160949,
         37831.33106264941,
         37794.76842895799,
         37748.79833357165,
         37712.55622361436,
         37653.772512871146,
         37722.173733197844,
         37749.83699182468,
         37720.685112879284,
         37722.59464293821,
         37756.65341310771,
         37797.85549133707,
         37833.29737013529,
         37842.74095748697,
         37817.94179295441,
         37807.40703002618,
         37760.10455520974,
         37800.28217309619,
         37763.02703297583,
         37705.02887240114,
         37759.93974750907,
         37754.70526488663,
         37763.732858945266,
         37793.64431403557,
         37788.10244930057,
         37812.43724553806,
         37792.90092884676,
         37777.892099231256,
         37728.290528272344,
         37686.93466932706,
         37583.05840249476,
         37482.57695014037,
         37390.36318955521,
         37419.91048390201,
         37184.1521968419,
         37277.07278556451,
         37229.85088047136,
         37321.06241885232,
         37610.606849353484,
         37651.86578364459,
         37646.91333313132,
         37479.4639007697,
         37514.914425042676,
         37493.67370201604,
         37330.133345788345,
         37318.30584731139,
         37381.08565581846,
         37344.83463883223,
         37261.18076239171,
         37286.01760264288,
         37345.42222276443,
         37456.8208086032,
         37105.72526483829,
         37153.393982179616,
         37070.88096186102,
         36852.04066154097,
         36770.39889445873,
         36822.44074613723,
         37058.31561754113,
         36918.99837698293,
         36956.580633701255,
         36886.50705537329,
         36821.20749959725,
         37010.074475659945,
         37069.97426871866,
         37275.70298263105,
         37265.896934563476,
         37224.82465955006,
         37186.24705220994,
         37133.160745663976,
         37005.502651825765,
         36930.718676559816,
         37071.64933422501,
         37116.67138301842,
         36950.07645028676,
         37101.48065349674,
         37089.56810257802,
         37226.8290786621,
         37198.39977907306,
         37433.766836494455,
         37394.07643077547,
         37498.44306463815,
         37913.65188183311,
         38170.41938875429,
         38028.624156199294,
         38261.22764442761,
         38247.067863730925,
         37986.86179095247,
         37823.821220234415,
         37802.23604377473,
         37896.495876000896,
         37963.24457231813,
         37919.148111568866,
         37927.545827586,
         37918.65956045931,
         38016.71960938207,
         38189.71043871588,
         38180.80133415089,
         38329.03761090173,
         38308.56019539666,
         37952.806530482,
         38165.99878207116,
         38247.80903444624,
         38154.816272782555,
         37847.408905601485,
         37853.04318282559,
         37776.59552224862,
         37833.07449689043,
         37855.02048653006,
         37830.37950137519,
         37686.82572817117,
         37720.56805996384,
         37798.33697303296,
         37810.34641654128,
         37846.54624031292,
         37707.41683816759,
         37900.831548547896,
         38049.71405708279,
         37983.48982564399,
         37883.492250512594,
         37890.29622632359,
         37789.336843645084,
         37666.695097959906,
         37702.55758118839,
         37699.89617454001,
         37870.39199235945,
         37865.352690164786,
         37779.33930176717,
         37714.451780373376,
         37550.7712513322,
         37674.89543904984,
         37746.35090844887,
         37730.6450303125,
         37791.6209042337,
         37730.058074457644,
         37758.36256606494,
         37766.35189696482,
         37711.81837585267,
         37686.883493873145,
         37952.97688055694,
         37993.781301693336,
         38056.21434006624,
         38178.60076031328
       ]
     },
     "price_change_percentage_24h_in_currency": 2.6201753025247867
   }
 */

struct CoinModel: Identifiable, Codable {
    let id, symbol, name: String
    let image: String
    let currentPrice: Double
    let marketCap, marketCapRank, fullyDilutedValuation: Double?
    let totalVolume, high24H, low24H, priceChange24H: Double?
    let priceChangePercentage24H: Double?
    let marketCapChange24H: Double?
    let marketCapChangePercentage24H: Double?
    let circulatingSupply, totalSupply, maxSupply, ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl: Double?
    let atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    let priceChangePercentage24HInCurrency: Double?
    let currnetHoldings: Double?
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
        case sparklineIn7D = "sparkline_in_7d"
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
        case currnetHoldings
    }
    
    func updateHoldings(amount: Double) -> CoinModel {
        return CoinModel(id: id, symbol: symbol,
                         name: name, image: image,
                         currentPrice: currentPrice,
                         marketCap: marketCap,
                         marketCapRank: marketCapRank,
                         fullyDilutedValuation: fullyDilutedValuation,
                         totalVolume: totalVolume,
                         high24H: high24H, low24H: low24H,
                         priceChange24H: priceChange24H,
                         priceChangePercentage24H: priceChangePercentage24H,
                         marketCapChange24H: marketCapChange24H,
                         marketCapChangePercentage24H: marketCapChangePercentage24H,
                         circulatingSupply: circulatingSupply,
                         totalSupply: totalSupply,
                         maxSupply: maxSupply, ath: ath,
                         athChangePercentage: athChangePercentage,
                         athDate: athDate, atl: atl,
                         atlChangePercentage: atlChangePercentage,
                         atlDate: atlDate, lastUpdated: lastUpdated,
                         sparklineIn7D: sparklineIn7D,
                         priceChangePercentage24HInCurrency: priceChangePercentage24HInCurrency,
                         currnetHoldings: amount)
    }
    
    var currentHoldingsValue: Double {
        return (currnetHoldings ?? 0) * currentPrice
    }
    
    var rank: Int {
        return Int(marketCapRank ?? 0)
    }
}

struct SparklineIn7D: Codable {
    let price: [Double]?
}
