//
//  MarketDataService.swift
//  SwiftuiCrypto
//
//  Created by KSH on 12/11/23.
//

import Foundation
import Combine

class MarketDataService {
    
    @Published var marketData: MarketDataModel? = nil
    var marketDataSubscription: AnyCancellable?
    
    init() {
        getData()
    }
    
    private func getData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
        
        marketDataSubscription = NetworkingManager.download(url: url)
        // decode - JSON 디코딩 수행, CoinModel타입의 배열로 변환
            .decode(type: GlobalData.self, decoder: JSONDecoder())
        // sink -  Combine의 Subscriber를 설정, 작업이 완료되면 무시하고, 실패한 경우에는 에러 메시지를 출력
        // receiveValue - CoinModel 배열을 받아온 후, 해당 데이터를 allCoins 배열에 저장하고 coinSubscription을 취소
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: {[weak self] (returnedGlobalData) in
                self?.marketData = returnedGlobalData.data
                self?.marketDataSubscription?.cancel()
            })
    }
}