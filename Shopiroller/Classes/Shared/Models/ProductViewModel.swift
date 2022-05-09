//
//  ProductViewModel.swift
//  Shopiroller
//
//  Created by Görkem Gür on 1.10.2021.
//

import Foundation

class ProductViewModel {
    
    var productListModel: ProductListModel?
    var productDetailModel: ProductDetailResponseModel?
    
    init(productListModel: ProductListModel? = nil, productDetailModel: ProductDetailResponseModel? = nil) {
        self.productDetailModel = productDetailModel
        self.productListModel = productListModel
    }
    
    func getTitle() -> String? {
        return productListModel?.title ?? (productDetailModel?.title ?? "")
    }
    
    func hasDiscount() -> Bool {
        if let campaingPrice = productDetailModel?.campaignPrice, campaingPrice != 0 {
            return true
        } else if let campaignPrice = productListModel?.campaignPrice, campaignPrice != 0 {
            return true
        } else {
            return false
        }
    }
    
    var discount: String {
        let discount = ""
        return discount.calculateDiscount(price: productListModel?.price ?? (productDetailModel?.price ?? 0.0), campaignPrice: productListModel?.campaignPrice ?? (productDetailModel?.campaignPrice ?? 0.0))
    }

    func getImage() -> String? {
        return productListModel?.featuredImage?.normal ?? (productDetailModel?.featuredImage?.normal)
    }
    
    func isShippingFree() -> Bool {
        if let productListModel = productListModel {
            return productListModel.shippingPrice == 0.0
        } else if let productDetailModel = productDetailModel {
            return (!(isUseFixPrice()) && productDetailModel.shippingPrice == 0.0)
        }
        return false
    }
    
    func isUseFixPrice() -> Bool {
        if let productDetailModel = productDetailModel {
            return (productDetailModel.useFixPrice == true && productDetailModel.shippingPrice == 0.0)
        } else if let productListModel = productListModel {
            return productListModel.shippingPrice != 0
        }
        return false
    }
    
    func isOutofStock() -> Bool {
        return productListModel?.stock == 0 || (productDetailModel?.stock == 0)
    }
    
    func getPrice() -> String {
        return String(productListModel?.price ?? (productDetailModel?.price ?? 0.0))
    }
    
    func getCurrency() -> String? {
        return productListModel?.currency?.currencySymbol ?? (productDetailModel?.currency?.currencySymbol)
    }
    
    func getCampaignPrice() -> String {
        return String(productListModel?.campaignPrice ?? (productDetailModel?.campaignPrice ?? 0.0))
    }
    
}
