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
        if(productDetailModel?.campaignPrice != 0) {
            return true
        }else{
            return false
        }
    }
    
    var discount: String {
        let discount = ""
        return discount.calculateDiscount(price: productListModel?.price ?? (productDetailModel?.price ?? 0.0), campaignPrice: productListModel?.campaignPrice ?? (productDetailModel?.campaignPrice ?? 0.0))
    }

    func getImage() -> String? {
        return productListModel?.featuredImage?.thumbnail ?? (productDetailModel?.featuredImage?.thumbnail)
    }
    
    func isShippingFree() -> Bool {
        return productListModel?.shippingPrice == 0.0 || (productDetailModel?.shippingPrice == 0.0)
    }
    
    func isStockOut() -> Bool {
        return productListModel?.stock == 0 || (productDetailModel?.stock == 0)
    }
    
    func getPrice() -> String {
        return String(productListModel?.price ?? (productDetailModel?.price ?? 0.0))
    }
    
    func getCurrency() -> String {
        return productDetailModel?.currency?.rawValue ?? ""
    }
    
    func getCampaignPrice() -> String {
        return String(productListModel?.campaignPrice ?? (productDetailModel?.campaignPrice ?? 0.0))
    }
    
}
