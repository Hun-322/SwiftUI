//
//  CoinLogoView.swift
//  SwiftuiCrypto
//
//  Created by KSH on 12/12/23.
//

import SwiftUI

struct CoinLogoView: View {
    
    let coin: CoinModel
    
    var body: some View {
        VStack {
            CoinImageView(coin: coin)
                .frame(width: 50, height: 50)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(.theme.accent)
                .lineLimit(1) //  텍스트 뷰에서 표시할 최대 라인 수를 지정
                .minimumScaleFactor(0.5) // 텍스트의 최소 축소 비율
            Text(coin.name)
                .font(.caption)
                .foregroundColor(.theme.secondaryText)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
        }
    }
}

struct CoinLogoView_PreView: PreviewProvider {
    static var previews: some View {
        Group {
            CoinLogoView(coin: dev.coin)
                .previewLayout(.sizeThatFits)
            
            CoinLogoView(coin: dev.coin)
                .preferredColorScheme(.light)
                .previewLayout(.sizeThatFits)
        }
    }
}
