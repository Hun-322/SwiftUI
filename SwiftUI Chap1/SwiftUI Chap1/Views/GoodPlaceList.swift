//
//  GoodPlaceList.swift
//  SwiftUI Chap1
//
//  Created by KSH on 2023/07/28.
//

import SwiftUI

struct GoodPlaceList: View {
    var body: some View {
        NavigationView {
            List(goodPlace) { goodPlace in
                NavigationLink {
                    GoodPlaceDetail(goodPlace: goodPlace)
                } label: {
                    GoodPlaceRow(goodPlace: goodPlace)
                }
            }
            .navigationTitle("GoodPlace")
        }
    }
}

struct GoodPlaceList_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE (2nd generation)", "iPhone XS Max"], id: \.self) { deviceName in
            GoodPlaceList()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
