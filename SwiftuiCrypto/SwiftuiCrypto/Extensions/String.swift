//
//  String.swift
//  SwiftuiCrypto
//
//  Created by KSH on 12/20/23.
//

import Foundation

extension String {
    
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
    }
}
