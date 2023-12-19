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
    ///   - 12.00 => "12.00"
    ///   - 1234 => "1.23천"
    ///   - 123456 => "12.35만"
    ///   - 12345678 => "1234.57만"
    ///   - 1234567890 => "12.35억"
    ///   - 123456789012 => "1234.57억"
    ///   - 12345678901234 => "12.34조"
    /// ```
    func formattedWithKoreanAbbreviations() -> String {
        let num = abs(self)
        let sign = (self < 0) ? "-" : ""
        
        switch num {
        case 1_000_000_000_000...:
            let formatted = num / 1_000_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)조"
        case 1_000_000_000...:
            let formatted = num / 1_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)억"
        case 1_000_000...:
            let formatted = num / 1_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)백만"
        case 10_000...:
            let formatted = num / 10_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)만"
        case 0...:
            return self.asNumberString()
            
        default:
            return "\(sign)\(self)"
        }
    }
}
