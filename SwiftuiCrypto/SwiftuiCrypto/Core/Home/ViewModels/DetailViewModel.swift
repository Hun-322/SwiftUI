//
//  DetailViewModel.swift
//  SwiftuiCrypto
//
//  Created by KSH on 12/17/23.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    private let coinDetailService: CoinDetailService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coinDetailService = CoinDetailService(coin: coin)
        self.addSubscribes()
    }
    
    private func addSubscribes() {
        
        coinDetailService.$coinDetails
            .sink { returnedCoinDetails in
                print("Recieved coin detail Data")
                print(returnedCoinDetails)
            }
            .store(in: &cancellables)
    }
}
