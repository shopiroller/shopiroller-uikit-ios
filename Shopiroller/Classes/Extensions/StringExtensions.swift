//
//  StringExtensions.swift
//  shopiroller
//
//  Created by Görkem Gür on 19.09.2021.
//

import UIKit


extension String {
    
    var length: Int {
        return count
    }
    
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }
    
    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    
    func calculateDiscount(price: Double , campaignPrice: Double) -> String {
        let discount = price - campaignPrice
        let percentage = (discount / price) * 100
        let discountedPercenteage = String(format: "%.0f", percentage)
        return "%\(discountedPercenteage)"
    }
    
}
