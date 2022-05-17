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
        static let aliasKey = "alias-key"
        static let language = "language"
        static let fallbackLanguage = "X-Fallback-Language"
        static let acceptLanguage = "Accept-Language"
    }
    
    
    struct UserDefaults {
        
        struct Key {
            static let fontFamily = "font_family"
            static let userId = "userId"
            static let userEmail = "userEmail"
            static let aliasKey = "aliasKey"
            static let apiKey = "apiKey"
            static let baseUrl = "baseUrl"
            static let appUserBaseUrl = "appUserBaseUrl"
            static let appUserAppKey = "appUserAppKey"
            static let appUserApiKey = "appUserApiKey"
            static let fallbackLanguage = "fallbackLanguage"
            static let appLanguage = "appLanguage"
            static let appTitle = "appTitle"

        }
        
        struct Notifications {
            static let userAddressListObserve = "userAddressListObserve"
            static let userConfirmOrderObserve = "userConfirmOrderObserve"
            static let orderInnerResponseObserve = "OrderResponseInnerObserve"
            static let updatePaymentMethodObserve = "updatePaymentMethodObserve"
            static let updateAddressMethodObserve = "updateAddressMethodObserve"
            static let updateShoppighCartObserve = "updateShoppingCartObserve"
            static let updateCheckOutInfoPage = "updateCheckOutInfoPage"
        }
        
    }
    
    
    struct NetworkDefault {
        
        struct Loading{
            static let isLoading = "isLoading"
        }
        
    }
    
    struct URLResults {
        static let paymentSuccess = "http://applyze-ecommerce-service/v1/paymentSuccess"
        static let paymentSuccess1 = "https://ecommerce.applyze.com/v2.0/paymentSuccess"
        static let paymentSuccess2 = "/paymentSuccess"
        static let paymentFailed = "http://applyze-ecommerce-service/v1/paymentFailure"
        static let paymentFailed1 = "https://ecommerce.applyze.com/v2.0/paymentFailure"
        static let paymentFailed2 = "/paymentFailure"
        static let productMaxQuantityPerOrderExceeded = "MaxQuantityPerOrderExceeded"
        static let productMaxStockExceeded = "MaxStockExceeded"
    }
    
    struct Query {
        
        struct Keys {
            static let userId = "userId"
            static let page = "page"
            static let perPage = "perPage"
            static let categoryId = "categoryId"
            static let sort = "sort"
            static let sortBy = "sortBy"
            static let brandId = "brandId"
            static let title = "title"
            static let countryId = "countryId"
            static let stateId = "stateId"
            static let searchText = "searchText"
            static let showcaseId = "showcaseId"
            static let priceMin = "price.Min"
            static let priceMax = "price.Max"
            static let stockMin = "stock.Min"
            static let shippingPrice = "FreeShipping"
            static let isThereCampaign = "isThereCampaign"
        }
        
        struct Values {
            static let userId = "61c4168a2c630dd87543d153"
            static let page = "1"
            static let productsPerPageSize = 15
        }
    }
    
    public struct ShoppingCart {
        
        public static var badgeCount = "badgeCount"
        public static var shoppingCartMessageType = "Campaign"
    }
    
    struct History {
        static let searchHistory = "searchHistory"
    }
    
    struct AddressType {
        static let Corporate = "Corporate"
        static let Individual = "Individual"
    }
    
    enum NavigationItemSelectorType {
        case goToCard
        case searchProduct
        case goBack
        case openOptions
    }
    
    struct SdkSettings {
        static let developmentMode = "developmentMode"
    }
    
}

