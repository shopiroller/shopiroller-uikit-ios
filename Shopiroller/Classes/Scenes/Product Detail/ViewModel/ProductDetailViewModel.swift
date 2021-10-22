//
//  ProductDetailViewModel.swift
//  shopiroller
//
//  Created by Görkem Gür on 7.10.2021.
//

import UIKit
import Kingfisher


public class ProductDetailViewModel: BaseViewModel {
    
    private var productId: String?
    private var productList: ProductDetailResponseModel?
    private var paymentSettings: PaymentSettingsResponeModel?
    
    var quantityCount = 1
    
    init (productId: String = String()) {
        self.productId = productId
    }
    
    func getProductTerms(success: (() -> Void)? = nil, error: ((ErrorViewModel) -> Void)? = nil) {
        SRNetworkManagerRequests.getPaymentSettings().response() {
            (result) in
            switch result {
            case .success(let response):
                self.paymentSettings = response.data
                DispatchQueue.main.async {
                    success?()
                }
            case .failure(let err):
                DispatchQueue.main.async {
                    error?(ErrorViewModel(error: err))
                }
            }
        }
    }
    

    func getProductDetail(success: (() -> Void)? = nil, error: ((ErrorViewModel) -> Void)? = nil) {
        SRNetworkManagerRequests.getProduct(productId: self.productId ?? "").response() {
            (result) in
            switch result{
            case .success(let response):
                self.productList = response.data
                DispatchQueue.main.async {
                    success?()
                }
            case .failure(let err):
                DispatchQueue.main.async {
                    error?(ErrorViewModel(error: err))
                }
            }
        }
    }
    
    func addProductToCart(success : (() -> Void)? = nil , error: ((ErrorViewModel) -> Void)? = nil){
        SRNetworkManagerRequests.addProductToShoppingCart(products: SRAddProductModel(productId: self.productId, quantity: self.quantityCount, displayName: productList?.title), userId: "78971cc6-bda1-45a4-adee-638317c5a6e9").response() {
            (result) in
            switch result {
            case.success(let _):
                DispatchQueue.main.async {
                   success?()
                }
            case .failure(let err):
                DispatchQueue.main.async {
                    error?(ErrorViewModel(error: err))
                }
            }
        }
    }
    
    func getShoppingCartCount(success: (() -> Void)? = nil, error: ((ErrorViewModel) -> Void)? = nil) {
        SRGlobalRequestManager.getShoppingCartCount(success: success, error: error)
    }
    
    func getTitle() -> String? {
       return productList?.title
    }
    
    func getItemCount() -> Int? {
        return productList?.images?.count ?? 0
    }
    
    func getImages(position : Int) -> ProductImageModel? {
        return productList?.images?[position]
    }
    
    func getImageArray() -> [ProductImageModel]? {
        return productList?.images
    }
    
    func getBrandImage() -> String? {
        productList?.brand?.icon
    }
    
    func isOutofStock() -> Bool {
        return productList?.maxQuantityPerOrder == quantityCount
    }
    
    func isShippingFree() -> Bool {
        return productList?.shippingPrice == 0.0
    }
    
    func hasDiscount() -> Bool {
        if(productList?.campaignPrice != 0) {
            return true
        }else{
            return false
        }
    }
    
    func getCurrency() -> String {
        if productList?.currency == "TRY" {
            return "TL"
        }else {
            return "$"
        }
    }
    
    func hasSituation() -> Bool {
        return isShippingFree() || isOutofStock()
    }
    
    func getShippingPrice() -> String {
        let fmt = NumberFormatter()
        fmt.numberStyle = .decimal
        return fmt.string(from: NSNumber(value: Double(productList?.shippingPrice ?? 0.0))) ?? ""
    }
    
    func getPrice() -> String {
        return String(productList?.price ?? 0.0)
    }
    
    func getCampaignPrice() -> String {
        return String(productList?.campaignPrice ?? 0.0)
    }
    
    var discount: String {
        let discount = ""
        return discount.calculateDiscount(price: productList?.price ?? 0.0, campaignPrice: productList?.campaignPrice ?? 0.0)
    }
    
    func getMaxQuantity() -> Int {
        return productList?.maxQuantityPerOrder ?? 0
    }
    
    func isQuantityMax() -> Bool {
        return productList?.maxQuantityPerOrder == quantityCount || productList?.stock == quantityCount
    }
    
    func getReturnExchangeTerms() -> String? {
        return paymentSettings?.cancellationProcedure
    }
    
    func getDeliveryTerms() -> String? {
        return paymentSettings?.deliveryConditions
    }
    
    func getDescriptionUrl() -> String? {
        return paymentSettings?.description
    }
    
    func getAppId() -> String? {
        return SRNetworkContext.appKey
    }
    
}
