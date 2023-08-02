//
//  GoodPlaceList.swift
//  SwiftUI Chap1
//
//  Created by KSH on 2023/07/28.
//

import SwiftUI

struct GoodPlaceList: View {
    @EnvironmentObject var modelData: ModelData
    @State private var showFavoritesOnly = false
    
    var filteredGoodPlace: [GoodPlace] {
        modelData.goodPlace.filter { goodPlace in
            (!showFavoritesOnly || goodPlace.isFavorite)
        }
    }
    var body: some View {
        NavigationView {
            List {
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Favorites only")
                }
                
                ForEach(filteredGoodPlace) { goodPlace in
                    NavigationLink {
                        GoodPlaceDetail(goodPlace: goodPlace)
                    } label: {
                        GoodPlaceRow(goodPlace: goodPlace)
                    }
                }
            }
            .navigationTitle("GoodPlace")
        }
    }
}

struct GoodPlaceList_Previews: PreviewProvider {
    static var previews: some View {
        GoodPlaceList()
    }
}
