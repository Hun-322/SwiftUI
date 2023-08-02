//
//  GoodPlaceDetail.swift
//  SwiftUI Chap1
//
//  Created by KSH on 2023/07/28.
//

import SwiftUI

struct GoodPlaceDetail: View {
    @EnvironmentObject var modelData: ModelData
    var goodPlace: GoodPlace
    
    var goodPlaceIndex: Int {
        modelData.goodPlace.firstIndex(where: { $0.id == goodPlace.id })!
    }
    var body: some View {
        ScrollView {
            MapView(coordinate: goodPlace.locationCoordinate)
                .ignoresSafeArea(edges: .top)
                .frame(height: 300)
            
            CircleImage(image: goodPlace.image)
                .offset(y: -130)
                .padding(.bottom, -130)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(goodPlace.name)
                        .font(.title)
                    FavoriteButton(isSet: $modelData.goodPlace[goodPlaceIndex].isFavorite)
                }
                
                HStack {
                    Text(goodPlace.park)
                    Spacer()
                    Text(goodPlace.state)
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                Divider()
                
                Text("About \(goodPlace.name)")
                    .font(.title2)
                Text(goodPlace.description)
            }
            .padding()
        }
        .navigationTitle(goodPlace.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct GoodPlaceDetail_Previews: PreviewProvider {
    static let modelData = ModelData()
    
    static var previews: some View {
        GoodPlaceDetail(goodPlace: modelData.goodPlace[0])
            .environmentObject(modelData)
    }
}
