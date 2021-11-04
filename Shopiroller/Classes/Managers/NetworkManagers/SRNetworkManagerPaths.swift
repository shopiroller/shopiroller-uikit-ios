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
    case makeOrder = "/orders/user/{userId}"
    case tryAgain = "/orders/complete"
    case getOrderList = "/orders"
    case getOrder = "/orders/"
    case shoppingCart = "/shopping-cart/"
    case validateShoppingCart = "/users/{userId}/shopping-cart/validate"
    case removeItemFromShoppingCart = "/users/{userId}/shopping-cart/items/{cartItemId}"
    case updateItemQuantity = "/users/{userId}/shopping-cart/items/{cartItemId}/quantity"
    case addProductToShoppingCart = "/shopping-cart/items"
    case clearShoppingCart = "/shopping-cart/items/"
    case getShoppingCartCount = "/shopping-cart/count"
    case failurePayment = "/orders/{orderId}/failure"
    case getSliders = "/sliders"
    case getCategories = "/categories"
    case getSubCategories = "/categories/{categoryId}"
    case getShowcase = "/showcases"
    case getFilterOptions = "/filterOptions"
    case users = "/users/"
    case addresses = "/addresses/"
    case defaultAddress = "/defaults"
    case shipping = "/shipping/"
    case billing = "/billing/"
    
    var name: String {
        switch self {
        case.addresses:
            return "/appuser/v1\(rawValue)"
//        case .authorizationServer:
//            return rawValue
        default:
            return "/ecommerce/v2\(rawValue)"
        }
    }
    
}

