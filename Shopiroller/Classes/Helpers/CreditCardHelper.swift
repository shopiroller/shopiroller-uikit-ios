//
//  CreditCardHelper.swift
//  Shopiroller
//
//  Created by Görkem Gür on 15.11.2021.
//

import Foundation

import Foundation
import UIKit

class CreditCardHelper {
    
    static func validateCardNumber(str: String)-> Bool? {
        if !str.isEmpty {
            var ints: [Int] = []
            
            for i in str.indices {
                ints.append(Int("\(str[i])") ?? 0)
            }
            var i = ints.count - 2
            while (i >= 0) {
                var j = ints[i]
                j *= 2
                if (j > 9) {
                    j = j % 10 + 1
                }
                ints[i] = j
                i -= 2
            }
            var sum = 0
            for anInt in ints {
                sum += anInt
            }
            return sum % 10 == 0
        }
        return false
    }
    
    static func formatCardNumber(cardNumber : String) -> String{
        var emptyString: String = ""
        let card = cardNumber.replacingOccurrences(of: " ", with: "")
        for i in 0 ..< card.count {
            let index = card.index(emptyString.startIndex, offsetBy: i)
            if i > 0 && i%4 == 0{
                emptyString += " "
            }
            emptyString += String(card[index])
        }
        return emptyString
    }
    
    static func formatExpireDate(date : String) -> String{
        var emptyString: String = ""
        var expireDate = date.replacingOccurrences(of: " ", with: "")
        
        if expireDate.count == 1 && Int(expireDate) ?? 0 > 1 {
            expireDate = "0" + expireDate
        }
        
        if expireDate.count == 2 && Int(expireDate) ?? 0 > 12 {
            expireDate = "12"
        }
        
        for i in 0 ..< expireDate.count {
            let index = expireDate.index(emptyString.startIndex, offsetBy: i)
            if i > 0 && i%2 == 0 {
                emptyString += "/"
            }
            if expireDate[index] != "/"  {
                emptyString += String(expireDate[index])
            }
        }
        return emptyString
    }
    
}

enum CardType: String {
    case Unknown, Amex, Visa, MasterCard, Diners, Discover, JCB, Elo, Hipercard, UnionPay

    static let allCards = [Amex, Visa, MasterCard, Diners, Discover, JCB, Elo, Hipercard, UnionPay]

    var regex : String {
        switch self {
        case .Visa:
           return "^4[0-9]{6,}([0-9]{3})?$"
        case .MasterCard:
           return "^(5[1-5][0-9]{4}|677189)[0-9]{5,}$"
        default:
           return ""
        }
    }
    
    var image : UIImage? {
        switch self {
        case .Visa:
            return .visaIcon
        case .MasterCard:
            return .masterCardIcon
        default:
           return nil
        }
    }
}

