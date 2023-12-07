//
//  UIApplication.swift
//  SwiftuiCrypto
//
//  Created by KSH on 12/7/23.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
