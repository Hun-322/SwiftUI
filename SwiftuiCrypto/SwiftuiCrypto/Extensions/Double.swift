//
//  Double.swift
//  SwiftuiCrypto
//
//  Created by KSH on 12/1/23.
//

import Foundation

extension Double {
    
    /// Double 값을 통화로 변환합니다.
    /// ```
    /// Convert 50084053.000000 to ₩50,084,053
    /// ```
    private var currnecyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = .current // <- default value
        formatter.currencyCode = "krw" // <- change currency
        formatter.currencySymbol = "₩" // <- change currnet symbol

        return formatter
    }
    
    /// Double 값을 문자열 통화로 변환합니다.
    /// ```
    /// Convert 50084053.000000 to "₩50,084,053"
    /// ```
    func asCurrnecy() -> String {
        let number = NSNumber(value: self)
        return currnecyFormatter.string(from: number) ?? "0원"
    }
    
    /// Double 값을 소수점 이하 2자리까지의 형식으로 문자열로 변환합니다.
    /// ```
    /// Convert 1.2345 to "1.23"
    /// ```
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    /// Double 값을 소수점 이하 2자리까지의 형식으로 문자열로 변환하며, 백분율 기호를 포함합니다.
    /// ```
    /// Convert 1.2345 to "1.23%"
    /// ```
    func asPercentString() -> String {
        return asNumberString() + "%"
    }
}
