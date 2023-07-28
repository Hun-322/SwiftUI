//
//  GoodPlaceRow.swift
//  SwiftUI Chap1
//
//  Created by KSH on 2023/07/28.
//

import SwiftUI

struct GoodPlaceRow: View {
    var goodPlace: GoodPlace
    
    var body: some View {
        HStack {
            goodPlace.image
                .resizable()
                .frame(width: 50, height: 50)
            Text(goodPlace.name)
            
            Spacer()
        }
    }
}

struct GoodPlaceRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GoodPlaceRow(goodPlace: goodPlace[0])
                .previewLayout(.fixed(width: 300, height: 70))
            GoodPlaceRow(goodPlace: goodPlace[1])
                .previewLayout(.fixed(width: 300, height: 70))
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
