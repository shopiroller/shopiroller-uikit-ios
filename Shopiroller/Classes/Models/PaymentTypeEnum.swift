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
    case Stripe3DS = "Stripe3DS"
    case Other
    
    var title: String {
        switch self {
        case .PayAtDoor:
            return "CashOnDelivery"
        case .Online:
            return "CreditCard"
        case .Online3DS:
            return "CreditCard"
        case .Transfer:
            return "Transfer"
        case .PayPal:
            return "Paypal"
        case .Stripe:
            return "Stripe"
        case .Stripe3DS:
            return "Stripe3DS"
        case .Other:
            return "Other"
        }
    }
    
    var description: String {
        switch self {
        case .PayAtDoor:
            return "e_commerce_payment_method_selection_pay_at_door".localized
        case .Online, .Online3DS:
            return "e_commerce_payment_method_selection_credit_card".localized
        case .Transfer:
            return "e_commerce_payment_method_selection_transfer".localized
        case .PayPal:
            return "e_commerce_payment_method_selection_paypal".localized
        case .Stripe3DS , .Stripe:
            return "e_commerce_payment_method_selection_stripe".localized
        case .Other:
            return "Other"
        }
    }

}
