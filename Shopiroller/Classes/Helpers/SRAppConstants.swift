//
//  SRAppConstants.swift
//  shopiroller
//
//  Created by Görkem Gür on 22.09.2021.
//

import Foundation


struct SRAppConstants {
    
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
        }
        
        struct Values {
            static let userId = "6141a20ac701a10ecce6178a"
            static let page = "1"
            static let productsPerPageSize = 15
        }
    }
    
    struct ShoppingCart {
        
        static var badgeCount = "badgeCount"
    }
    
    enum NavigationItemSelectorType {
        case goToCard
        case searchProduct
        case openOptions
    }
}
