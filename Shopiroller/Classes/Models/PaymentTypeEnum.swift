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
        }
    }
    
    var description: String {
        switch self {
        case .PayAtDoor:
            return "checkout-payment-selected-payment-method-pay-at-the-door-placeholder".localized
        case .Online:
            return "checkout-payment-selected-payment-method-credit-cart-placeholder".localized
        case .Online3DS:
            return "checkout-payment-selected-payment-method-credit-cart-placeholder".localized
        case .Transfer:
            return "checkout-payment-selected-payment-method-transfer-bank-placeholder".localized
        case .PayPal:
            return "checkout-payment-selected-payment-method-paypal-placeholder".localized
        case .Stripe:
            return "checkout-payment-selected-payment-method-stripe-placeholder".localized
        case .Stripe3DS:
            return "checkout-payment-selected-payment-method-stripe-placeholder".localized
        }
    }

}
