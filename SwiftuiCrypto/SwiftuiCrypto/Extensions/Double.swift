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
    
    /// Convert a Double to a String with K, M, Bn, Tr abbreviations.
    /// ```
    /// Convert 12 to 12.00
    /// Convert 1234 to 1.23K
    /// Convert 123456 to 123.45K
    /// Convert 12345678 to 12.34M
    /// Convert 1234567890 to 1.23Bn
    /// Convert 123456789012 to 123.45Bn
    /// Convert 12345678901234 to 12.34Tr
    /// ```
    func formattedWithAbbreviations() -> String {
        let num = abs(Double(self))
        let sign = (self < 0) ? "-" : ""

        switch num {
        case 1_000_000_000_000...:
            let formatted = num / 1_000_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Tr"
        case 1_000_000_000...:
            let formatted = num / 1_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Bn"
        case 1_000_000...:
            let formatted = num / 1_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)M"
        case 1_000...:
            let formatted = num / 1_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)K"
        case 0...:
            return self.asNumberString()

        default:
            return "\(sign)\(self)"
        }
    }
}
