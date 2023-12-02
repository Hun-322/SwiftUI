//
//  SwiftuiCryptoApp.swift
//  SwiftuiCrypto
//
//  Created by KSH on 11/29/23.
//

import SwiftUI

@main
struct SwiftuiCryptoApp: App {
    
    @StateObject private var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
    }
}
