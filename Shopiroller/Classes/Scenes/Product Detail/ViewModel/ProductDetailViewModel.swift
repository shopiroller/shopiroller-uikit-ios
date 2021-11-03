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
    private var productDetailModel: ProductDetailResponseModel?
    private var paymentSettings: PaymentSettingsResponeModel?
    
    var quantityCount = 1
    private var popUpState: PopUpState = .deliveryTerms
    
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
                self.productDetailModel = response.data
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
        SRNetworkManagerRequests.addProductToShoppingCart(products: SRAddProductModel(productId: self.productId, quantity: self.quantityCount, displayName: productDetailModel?.title), userId: "78971cc6-bda1-45a4-adee-638317c5a6e9").response() {
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
       return productDetailModel?.title
    }
    
    func getItemCount() -> Int? {
        return productDetailModel?.images?.count ?? 0
    }
    
    func getImages(position : Int) -> ProductImageModel? {
        return productDetailModel?.images?[position]
    }
    
    func getImageArray() -> [ProductImageModel]? {
        return productDetailModel?.images
    }
    
    func getBrandImage() -> String? {
        productDetailModel?.brand?.icon
    }
    
    func isOutofStock() -> Bool {
        return productDetailModel?.maxQuantityPerOrder == quantityCount
    }
    
    func isShippingFree() -> Bool {
        return productDetailModel?.shippingPrice == 0.0
    }
    
    func hasDiscount() -> Bool {
        if(productDetailModel?.campaignPrice != 0) {
            return true
        }else{
            return false
        }
    }
    
    func getCurrency() -> String {
        if productDetailModel?.currency == "TRY" {
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
        return fmt.string(from: NSNumber(value: Double(productDetailModel?.shippingPrice ?? 0.0))) ?? ""
    }
    
    func getPrice() -> String {
        return String(productDetailModel?.price ?? 0.0)
    }
    
    func getCampaignPrice() -> String {
        return String(productDetailModel?.campaignPrice ?? 0.0)
    }
    
    var discount: String {
        let discount = ""
        return discount.calculateDiscount(price: productDetailModel?.price ?? 0.0, campaignPrice: productDetailModel?.campaignPrice ?? 0.0)
    }
    
    func getMaxQuantity() -> Int {
        return productDetailModel?.maxQuantityPerOrder ?? 0
    }
    
    func isQuantityMax() -> Bool {
        return productDetailModel?.maxQuantityPerOrder == quantityCount || productDetailModel?.stock == quantityCount
    }
    
    func getReturnExchangeTerms() -> String? {
        return paymentSettings?.cancellationProcedure
    }
    
    func getDeliveryTerms() -> String? {
        return paymentSettings?.deliveryConditions
    }
    
    func getDescription() -> String? {
        return productDetailModel?.description
    }
    
    func getAppId() -> String? {
        return SRNetworkContext.appKey
    }
    
    func getReturnExchangePopUpViewModel() -> PopUpViewModel {
        popUpState = .returnExchange
        return PopUpViewModel(image: .paymentFailed, title: "return-exchange-terms-title".localized, description: getReturnExchangeTerms() , firstButton: PopUpButtonModel(title: "product-detail-back-to-product-button-text".localized, type: .lightButton), secondButton: nil)
    }

    func getDeliveryTermsPopUpViewModel() -> PopUpViewModel {
        popUpState = .deliveryTerms
        return PopUpViewModel(image: .paymentFailed, title: "delivery-terms-title".localized, description: getDeliveryTerms()?.localized , firstButton: PopUpButtonModel(title: "product-detail-back-to-product-button-text".localized, type: .lightButton), secondButton: nil)
    }

    func getSoldOutPopUpViewModel() -> PopUpViewModel {
        popUpState = .soldOut
        return PopUpViewModel(image: .backIcon, title: "product-detail-out-of-stock-title".localized, description: "product-detail-out-of-stock-description".localized , firstButton: PopUpButtonModel(title: "product-detail-back-to-product-list-button-text".localized, type: .lightButton), secondButton: nil)
    }
    
    func getMaxQuantityPopUpViewModel() -> PopUpViewModel {
        popUpState = .maxQuantity
        return PopUpViewModel(image: .backIcon, title: "product-detail-maximum-product-quantity-title".localized, description: "product-detail-maximum-product-quantity-description".localized , firstButton: PopUpButtonModel(title: "product-detail-back-to-product-button-text".localized, type: .lightButton), secondButton: nil)
    }
    
    func isStateSoldOut() -> Bool {
        return popUpState == .soldOut
    }
}

enum PopUpState {
    case returnExchange, deliveryTerms, soldOut, maxQuantity
}
