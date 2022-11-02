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
    
    case TRY
    case EUR
    case USD
    case GBP
    case IRR
    case NOK
    case RUB
    
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
