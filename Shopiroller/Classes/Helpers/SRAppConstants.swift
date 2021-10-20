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
        }
        
        struct Values {
            static let page = "1"
            static let productsPerPageSize = 15
            static let userId = "78971cc6-bda1-45a4-adee-638317c5a6e9"
        }
    }
}
