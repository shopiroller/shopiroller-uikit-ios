//
//  ProductDetailViewModel.swift
//  shopiroller
//
//  Created by Görkem Gür on 7.10.2021.
//

import UIKit
import Kingfisher


public class ProductDetailViewModel {
    
    private var productId: String?
    private var productList: ProductDetailResponseModel?
    private var paymentSettings: PaymentSettingsResponeModel?
    
    private let networkManager: SRNetworkManager
    
    var quantityCount = 0
    
    init (products: String = String() , networkManager : SRNetworkManager = SRNetworkManager()) {
        self.productId = products
        self.networkManager = networkManager
    }
    
    func getProductTerms(succes: (() -> Void)? = nil, error: ((ErrorViewModel) -> Void)? = nil) {
        SRNetworkManagerRequests.getPaymentSettings().response(using: networkManager) {
            (result) in
            switch result {
            case .success(let response):
                self.paymentSettings = response.data
                DispatchQueue.main.async {
                    succes?()
                }
            case .failure(let err):
                DispatchQueue.main.async {
                    error?(ErrorViewModel(error: err))
                }
            }
        }
    }
    
    func getProductDetail(succes: (() -> Void)? = nil, error: ((ErrorViewModel) -> Void)? = nil) {
        SRNetworkManagerRequests.getProduct(productId: self.productId ?? "").response(using: networkManager) {
            (result) in
            switch result{
            case .success(let response):
                self.productList = response.data
                DispatchQueue.main.async {
                    succes?()
                }
            case .failure(let err):
                DispatchQueue.main.async {
                    error?(ErrorViewModel(error: err))
                }
            }
        }
        
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
        return productList?.stock == 0
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
        return productList?.maxQuantityPerOrder == quantityCount
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
    
}
