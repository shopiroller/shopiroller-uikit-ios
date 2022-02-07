//
//  SRNetworkManagerPaths.swift
//  shopiroller
//
//  Created by Görkem Gür on 17.09.2021.
//

import Foundation

enum SRNetworkManagerPaths: String {

    case getProductsWithAdvancedFiltered = "/products/advanced-filtered"
    case getProducts = "/products"
    case getProduct = "/products/"
    case getPaymentSettings = "/paymentSettings"
    case makeOrder = "/orders/user"
    case tryAgain = "/orders/complete"
    case getOrderList = "/orders"
    case getOrder = "/orders/"
    case shoppingCart = "/shopping-cart/"
    case shoppingCartValidate = "/shopping-cart/validate"
    case quantity = "/quantity/"
    case shoppingCartItems = "/shopping-cart/items/"
    case getShoppingCartCount = "/shopping-cart/count"
    case failurePayment = "/orders/failurePayment"
    case completePayment = "/orders/completePayment"
    case getSliders = "/sliders"
    case getCategories = "/categories"
    case getSubCategories = "/categories/{categoryId}"
    case getShowcase = "/showcases"
    case getFilterOptions = "/filterOptions"
    case users = "/users/"
    case addresses = "/addresses/"
    case countries = "countries/"
    case states = "states/"
    case cities = "cities/"
    case defaultAddress = "/defaults"
    case billingAddress = "/billing"
    case shippingAddress = "/shipping"
    case shipping = "/shipping/"
    case billing = "/billing/"
    
    var name: String {
        switch self {
        case.addresses:
            return "/appuser/v1\(rawValue)"
//        case .authorizationServer:
//            return rawValue
        default:
            return "/v2\(rawValue)"
        }
    }
    
}

