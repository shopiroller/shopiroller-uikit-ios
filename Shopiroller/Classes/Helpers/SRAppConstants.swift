//
//  SRAppConstants.swift
//  shopiroller
//
//  Created by Görkem Gür on 22.09.2021.
//

import Foundation


public struct SRAppConstants {
    
    struct Header {
        static let apiKey = "api-Key"
        static let appKey = "app-Key"
        static let language = "language"
        static let fallbackLanguage = "X-Fallback-Language"
        static let acceptLanguage = "Accept-Language"
    }
    
    
    struct UserDefaults {
        
        struct Key {
            static let fontFamily = "font_family"
        }
        
        struct Notifications {
            static let userAddressListObserve = "userAddressListObserve"
            static let userConfirmOrderObserve = "userConfirmOrderObserve"
            static let orderInnerResponseObserve = "OrderResponseInnerObserve"
        }
        
    }
    
    
    struct NetworkDefault {
        
        struct Loading{
            static let isLoading = "isLoading"
        }
        
    }
    
    struct Query {
        
        struct Keys {
            static let userId = "userId"
            static let page = "page"
            static let perPage = "perPage"
            static let categoryId = "categoryId"
            static let countryId = "countryId"
            static let stateId = "stateId"
        }
        
        struct Values {
            static let userId = "6141a20ac701a10ecce6178a"
            static let page = "1"
            static let productsPerPageSize = 15
        }
    }
    
    public struct ShoppingCart {
        
        public static var badgeCount = "badgeCount"
    }
    
    enum NavigationItemSelectorType {
        case goToCard
        case searchProduct
        case goBack
        case openOptions
    }
}

