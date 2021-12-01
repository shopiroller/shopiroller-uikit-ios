//
//  CurrencyEnum.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 1.12.2021.
//

import Foundation

enum CurrencyEnum: String, EnumDecodable, Encodable {
    static var `default`: CurrencyEnum {
        return .TRY
    }
    
    case TRY = "TRY"
    case EUR = "EUR"
    case USD = "USD"
    case GBP = "GBP"
    case IRR = "IRR"
    case NOK = "NOK"
    case RUB = "RUB"
    
    var currencySymbol: String {
        switch self {
        case .TRY:
            return "₺"
        case .EUR:
            return "€"
        case .USD:
            return "$"
        case .GBP:
            return "£"
        case .IRR:
            return "﷼"
        case .NOK:
            return "kr"
        case .RUB:
            return "\u{20BD}"
        }
    }
}
