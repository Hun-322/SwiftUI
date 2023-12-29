//
//  CoinDataService.swift
//  SwiftuiCrypto
//
//  Created by KSH on 12/3/23.
//

import Foundation
import Combine

final class CoinDataService {
    
    @Published var allCoins: [CoinModel] = []
    
    private var coinSubscription: AnyCancellable?
    
    init() {
        getCoins()
    }
    
    func getCoins(_ networkService: NetworkServable = NetworkService()) {
        let coinDataAPI = CoinDataAPI(vsCurrency: "krw",
                                      order: "market_cap_desc",
                                      priceChangePercentage: "24h")

        coinSubscription = networkService.request(coinDataAPI)
        // decode - JSON 디코딩 수행, CoinModel타입의 배열로 변환
//            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
        // sink -  Combine의 Subscriber를 설정, 작업이 완료되면 무시하고, 실패한 경우에는 에러 메시지를 출력
        // receiveValue - CoinModel 배열을 받아온 후, 해당 데이터를 allCoins 배열에 저장하고 coinSubscription을 취소
            .sink(receiveCompletion: networkService.handleCompletion, receiveValue: { [weak self] (returnCoins) in
                self?.allCoins = returnCoins
                self?.coinSubscription?.cancel()
            })
    }
}
