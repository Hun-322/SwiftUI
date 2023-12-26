//
//  CoinDetailService.swift
//  SwiftuiCrypto
//
//  Created by KSH on 12/17/23.
//

import Foundation
import Combine

class CoinDetailService {
    
    @Published var coinDetails: CoinDetailModel? = nil
    
    var coinDetailSubscription: AnyCancellable?
    let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        getCoinDetails()
    }
    
    func getCoinDetails(_ networkService: NetworkServable = NetworkService()) {
        let coinDetailAPI = CoinDetailAPI(id: coin.id)
        
        coinDetailSubscription = networkService.request(coinDetailAPI)
        // decode - JSON 디코딩 수행, CoinModel타입의 배열로 변환
            .receive(on: DispatchQueue.main)
        // sink -  Combine의 Subscriber를 설정, 작업이 완료되면 무시하고, 실패한 경우에는 에러 메시지를 출력
        // receiveValue - CoinModel 배열을 받아온 후, 해당 데이터를 allCoins 배열에 저장하고 coinSubscription을 취소
            .sink(receiveCompletion: networkService.handleCompletion, receiveValue: {[weak self] (returendCoinDetails) in
                self?.coinDetails = returendCoinDetails
                self?.coinDetailSubscription?.cancel()
            })
    }
}
