//
//  ContentView.swift
//  SwiftUI Chap1
//
//  Created by KSH on 2023/07/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            MapView()
                .ignoresSafeArea(edges: .top)
                .frame(height: 300)
            
            CircleImage()
                .offset(y: -130)
                .padding(.bottom, -130)
            
            VStack(alignment: .leading) {
                Text("저녁 메뉴")
                    .font(.title)
                
                HStack {
                    Text("불족발을 먹었어요.")
                    Spacer()
                    Text("스프라이트 제로도 먹었어요.")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                Divider() // 구분선
                
                Text("맵기")
                    .font(.title2)
                Text("⭐️⭐️⭐️⭐️")
                
            }
            .padding()
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
