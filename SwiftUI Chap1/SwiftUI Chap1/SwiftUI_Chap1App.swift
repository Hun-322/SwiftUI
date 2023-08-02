//
//  SwiftUI_Chap1App.swift
//  SwiftUI Chap1
//
//  Created by KSH on 2023/07/25.
//

import SwiftUI

@main
struct SwiftUI_Chap1App: App {
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
