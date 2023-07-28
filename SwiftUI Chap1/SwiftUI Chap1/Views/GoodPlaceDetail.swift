//
//  GoodPlaceDetail.swift
//  SwiftUI Chap1
//
//  Created by KSH on 2023/07/28.
//

import SwiftUI

struct GoodPlaceDetail: View {
    var goodPlace: GoodPlace
    
    var body: some View {
        ScrollView {
            MapView(coordinate: goodPlace.locationCoordinate)
                .ignoresSafeArea(edges: .top)
                .frame(height: 300)
            
            CircleImage(image: goodPlace.image)
                .offset(y: -130)
                .padding(.bottom, -130)
            
            VStack(alignment: .leading) {
                Text(goodPlace.name)
                    .font(.title)
                
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
    static var previews: some View {
        GoodPlaceDetail(goodPlace: goodPlace[0])
    }
}
