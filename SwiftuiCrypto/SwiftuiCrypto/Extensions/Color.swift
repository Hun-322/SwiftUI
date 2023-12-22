//
//  Color.swift
//  SwiftuiCrypto
//
//  Created by KSH on 11/29/23.
//

import SwiftUI

extension Color {
    
    static let theme = ColorTheme()
    static let launch = LauncTheme()
    
}

struct ColorTheme {
    
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("redColor")
    let secondaryText = Color("SecondaryTextColor")
}

struct LauncTheme {
    
    let accent = Color("LaunchAccentColor")
    let background = Color("LaunchBackgroundColor")
}
