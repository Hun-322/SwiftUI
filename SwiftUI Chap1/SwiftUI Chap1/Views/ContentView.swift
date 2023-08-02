//
//  ContentView.swift
//  SwiftUI Chap1
//
//  Created by KSH on 2023/07/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GoodPlaceList()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
