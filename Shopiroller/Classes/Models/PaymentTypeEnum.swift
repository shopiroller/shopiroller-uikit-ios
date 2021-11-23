//
//  PaymentTypeEnum.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 21.10.2021.
//

import Foundation

enum PaymentTypeEnum: String, Codable {
    
    case PayAtDoor = "PayAtDoor"
    case Online = "Online"
    case Online3DS = "Online3DS"
    case Transfer = "Transfer"
    case PayPal = "PayPal"
    case Stripe = "Stripe"
    
    var title: String {
        switch self {
        case .PayAtDoor:
            return "CashOnDelivery".localized
        case .Online:
            return "CreditCard".localized
        case .Online3DS:
            return "CreditCard".localized
        case .Transfer:
            return "Transfer".localized
        case .PayPal:
            return "Paypal".localized
        case .Stripe:
            return "Stripe".localized
        }
    }

}
