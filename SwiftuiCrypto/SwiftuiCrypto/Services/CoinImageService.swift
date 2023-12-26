//
//  CoinImageService.swift
//  SwiftuiCrypto
//
//  Created by KSH on 12/5/23.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    
    @Published var image: UIImage? = nil
    
    private var imageSubscription: AnyCancellable?
    private let coin: CoinModel
    private let fileManager = LocalFileManager.instance
    private let folderName = "coin_image"
    private let imageName: String
    
    init(coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            image = savedImage
            print("파일 관리자에서 이미지를 검색했습니다.")
        } else {
            print("이미지 다운로드 중입니다.")
            downloadCoinImage()
        }
    }
    
    private func downloadCoinImage(_ networkService: NetworkServable = NetworkService()) {
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription = networkService.request(url: url)
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    // 이미지 다운로드 중 에러 처리
                    print("Image download error: \(error.localizedDescription)")
                }
            }, receiveValue: {[weak self] (returndImage) in
                guard let self = self, let downloadImage = returndImage else { return }
                self.image = returndImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: downloadImage, imageName: imageName, folderName: folderName)
            })
    }
}
