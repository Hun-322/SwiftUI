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
    
    private func getCoins() {
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=krw&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h&locale=ko") else { return }
        
        // dataTaskPublisher - 네트워크 요청을 시작하고 결과를 publisher로 반환하는 메서드
        coinSubscription = URLSession.shared.dataTaskPublisher(for: url)
        // subscribe - 네트워크 요청을 수행할 큐를 설정하는 메서드
            .subscribe(on: DispatchQueue.global())
            .tryMap { (output) -> Data in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
        // receive - 메인 큐에서 수행되도록 설정하는 메서드
            .receive(on: DispatchQueue.main)
        // decode - JSON 디코딩 수행, CoinModel타입의 배열로 변환
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
        // sink -  Combine의 Subscriber를 설정, 작업이 완료되면 무시하고, 실패한 경우에는 에러 메시지를 출력
            .sink { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                } // CoinModel 배열을 받아온 후, 해당 데이터를 allCoins 배열에 저장하고 coinSubscription을 취소
            } receiveValue: { [weak self] (returnCoins) in
                self?.allCoins = returnCoins
                self?.coinSubscription?.cancel()
            }

    }
}
