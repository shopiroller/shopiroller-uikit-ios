//
//  SRSRNetworkRequestManagers.swift
//  shopiroller
//
//  Created by Görkem Gür on 19.09.2021.
//

import Foundation

struct SRNetworkManagerRequests {
    
    static func getProductsWithAdvancedFiltered(urlQueryItems: [URLQueryItem] = []) -> SRNetworkRequestManager<ProductDetailResponseModel> {
        return SRNetworkRequestManager(httpMethod: .get, path: .getProductsWithAdvancedFiltered, resourceType: ProductDetailResponseModel.self,urlQueryItems: urlQueryItems)
    }
    
    static func getProducts(urlQueryItems: [URLQueryItem] = []) -> SRNetworkRequestManager<[ProductListModel]> {
        return SRNetworkRequestManager(httpMethod: .get, path: .getProducts, resourceType: [ProductListModel].self, urlQueryItems: urlQueryItems)
        
    }
    static func getProduct(productId: String) -> SRNetworkRequestManager<ProductDetailResponseModel> {
        return SRNetworkRequestManager(httpMethod: .get, path: .getProduct, subpath:
        "/\(productId)",resourceType: ProductDetailResponseModel.self)
    }
    
    static func getPaymentSettings() -> SRNetworkRequestManager<PaymentSettingsResponeModel> {
        return SRNetworkRequestManager(httpMethod: .get, path: .getPaymentSettings
                                       , resourceType: PaymentSettingsResponeModel.self)
    }
    
    static func makeOrder(_ makeOrder: MakeOrderAddressModel,userId: String) -> SRNetworkRequestManager<SROrderResponseInnerModel> {
        return SRNetworkRequestManager(httpMethod: .post, path: .makeOrder, subpath:
                                        "/\(userId)", resourceType: SROrderResponseInnerModel.self, httpBody: makeOrder.data)
    }
    
    static func tryAgain(_ completeOrder: CompleteOrderModel) -> SRNetworkRequestManager<SROrderResponseInnerModel> {
        return SRNetworkRequestManager(httpMethod: .post, path: .tryAgain, resourceType: SROrderResponseInnerModel.self, httpBody: completeOrder.data)
    }
    
    
    static func getOrderList(urlQueryItems: [URLQueryItem] = []) -> SRNetworkRequestManager<SROrderModel> {
        return SRNetworkRequestManager(httpMethod: .get, path: .getOrderList, resourceType: SROrderModel.self , urlQueryItems: urlQueryItems)
    }
    
    static func getOrder(orderId: String) -> SRNetworkRequestManager<OrderDetailModel> {
        return SRNetworkRequestManager(httpMethod: .get, path: .getOrder, subpath: "/\(orderId)", resourceType: OrderDetailModel.self)
    }
    
    static func getShoppingCart(userId: String) -> SRNetworkRequestManager<SRShoppingCartResponseModel> {
        return SRNetworkRequestManager(httpMethod: .get, path: .getShoppingCart, subpath: "/\(userId)", resourceType: SRShoppingCartResponseModel.self)
    }
    
    static func validateShoppingCart(userId: String,cartItemId: String) -> SRNetworkRequestManager<SRShoppingCartResponseModel> {
        
        return SRNetworkRequestManager(httpMethod: .get, path: .validateShoppingCart,subpath: "/\(userId)" + "/\(cartItemId)", resourceType: SRShoppingCartResponseModel.self)
    }
    
    static func removeItemFromShoppingCart(userId: String, cartItemId: String) -> SRNetworkRequestManager<SuccessResponse> {
        return SRNetworkRequestManager(httpMethod: .delete, path: .removeItemFromShoppingCart, subpath: "/\(userId)" + "/\(cartItemId)" , resourceType: SuccessResponse.self)
    }
    
    static func updateItemQuantity(userId: String, cartItemId: String) -> SRNetworkRequestManager<SuccessResponse> {
        return SRNetworkRequestManager(httpMethod: .put, path: .updateItemQuantity, subpath: "/\(userId)" + "/\(cartItemId)", resourceType: SuccessResponse.self)
    }
    
    static func addProductToShoppingCart(_ quantity: SRAddProductModel,userId: String) -> SRNetworkRequestManager<SuccessResponse> {
        return SRNetworkRequestManager(httpMethod: .post, path: .addProductToShoppingCart, subpath: "/\(userId)", resourceType: SuccessResponse.self, httpBody: quantity.data)
    }
    
    static func clearShoppingCart(userId: String) -> SRNetworkRequestManager<SuccessResponse> {
        return SRNetworkRequestManager(httpMethod: .delete, path: .clearShoppingCart,subpath: "/\(userId)" ,resourceType: SuccessResponse.self)
    }
    
    static func getShoppingCartCount(userId: String) -> SRNetworkRequestManager<ShoppingCartCount> {
        return SRNetworkRequestManager(httpMethod: .get, path: .getShoppingCartCount,
                                       subpath: "/\(userId)",resourceType: ShoppingCartCount.self)
    }
    
    static func failurePayment(orderId: String) -> SRNetworkRequestManager<SuccessResponse> {
        return SRNetworkRequestManager(httpMethod: .post, path: .failurePayment, subpath: "/\(orderId)", resourceType: SuccessResponse.self)
    }
    
    static func getSliders() -> SRNetworkRequestManager<[SRSliderDataModel]> {
        return SRNetworkRequestManager(httpMethod: .get, path: .getSliders, resourceType: [SRSliderDataModel].self)
    }
    
    static func getCategories() -> SRNetworkRequestManager<[SRCategoryResponseModel]> {
        return SRNetworkRequestManager(httpMethod: .get, path: .getCategories, resourceType: [SRCategoryResponseModel].self)
    }
    
    static func getSubCategories(categoryId: String) -> SRNetworkRequestManager<SRCategoryResponseModel> {
        return SRNetworkRequestManager(httpMethod: .get, path: .getSubCategories, resourceType: SRCategoryResponseModel.self)
    }
    
    static func getShowCase() -> SRNetworkRequestManager<[SRShowcaseResponseModel]> {
        return SRNetworkRequestManager(httpMethod: .get, path: .getShowcase, resourceType: [SRShowcaseResponseModel].self)
    }
    
    static func getFilterOptions(urlQueryItems: [URLQueryItem] = []) -> SRNetworkRequestManager<SRFilterOptionsResponseModel> {
        return SRNetworkRequestManager(httpMethod: .get, path: .getFilterOptions , resourceType: SRFilterOptionsResponseModel.self, urlQueryItems: urlQueryItems)
    }
    
}

