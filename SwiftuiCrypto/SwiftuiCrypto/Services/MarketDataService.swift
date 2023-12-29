//
//  MarketDataService.swift
//  SwiftuiCrypto
//
//  Created by KSH on 12/11/23.
//

import Foundation
import Combine

final class MarketDataService {
    
    @Published var marketData: MarketDataModel? = nil
    private var marketDataSubscription: AnyCancellable?
    
    init() {
        getData()
    }
    
    func getData(_ networkService: NetworkServable = NetworkService()) {
        let marketDataAPI = MarketDataAPI()
        
        marketDataSubscription = networkService.request(marketDataAPI)
        // decode - JSON 디코딩 수행, CoinModel타입의 배열로 변환
            .receive(on: DispatchQueue.main)
        // sink -  Combine의 Subscriber를 설정, 작업이 완료되면 무시하고, 실패한 경우에는 에러 메시지를 출력
        // receiveValue - CoinModel 배열을 받아온 후, 해당 데이터를 allCoins 배열에 저장하고 coinSubscription을 취소
            .sink(receiveCompletion: networkService.handleCompletion, receiveValue: {[weak self] (returnedGlobalData) in
                self?.marketData = returnedGlobalData.data
                self?.marketDataSubscription?.cancel()
            })
    }
}
