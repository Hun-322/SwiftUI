//
//  CoinDataService.swift
//  SwiftuiCrypto
//
//  Created by KSH on 12/3/23.
//

import Foundation
import Combine

class CoinDataService {
    
    @Published var allCoins: [CoinModel] = []
    
    var coinSubscription: AnyCancellable?
    
    init() {
        getCoins()
    }
    
    func getCoins() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=krw&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h&locale=ko") else { return }
        
        coinSubscription = NetworkingManager.download(url: url)
        // decode - JSON 디코딩 수행, CoinModel타입의 배열로 변환
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
        // sink -  Combine의 Subscriber를 설정, 작업이 완료되면 무시하고, 실패한 경우에는 에러 메시지를 출력
        // receiveValue - CoinModel 배열을 받아온 후, 해당 데이터를 allCoins 배열에 저장하고 coinSubscription을 취소
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnCoins) in
                self?.allCoins = returnCoins
                self?.coinSubscription?.cancel()
            })
    }
}
