//
//  ProductDetailViewModel.swift
//  shopiroller
//
//  Created by Görkem Gür on 7.10.2021.
//

import UIKit
import Kingfisher
import AVFoundation


public class ProductDetailViewModel: SRBaseViewModel {
    
    private var productId: String?
    private var productDetailModel: ProductDetailResponseModel?
    private var paymentSettings: PaymentSettingsResponeModel?
    private var variantData: [VariantDataModel]?
    private var variationGroups: [VariationGroups]?
    private var variantsList: [ProductDetailResponseModel]?
    private var productImagesList: [ProductImageModel] = [ProductImageModel]()
    
    var quantityCount = 1
    private var isPopUpState: Bool = false
    private var isUserFriendly: Bool = false
    
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
                self.variantData = self.productDetailModel?.variantData
                self.variantsList = self.productDetailModel?.variants
                self.variationGroups = self.productDetailModel?.variationGroups
                self.setVariantListVariables()
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
        SRNetworkManagerRequests.addProductToShoppingCart(products: SRAddProductModel(productId: self.productId, quantity: self.quantityCount, displayName: productDetailModel?.title), userId: SRAppContext.userId).response() {
            (result) in
            switch result {
            case.success(let response):
                if let count = response.data?.shoppingCardCount {
                    if count >= 10 {
                        SRAppContext.shoppingCartCount = "\(9)" + "+"
                    } else {
                        SRAppContext.shoppingCartCount = "\(count)"
                    }
                }
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: Notification.Name(SRAppConstants.UserDefaults.Notifications.updateShoppighCartObserve), object: nil)
                    success?()
                }
            case .failure(let err):
                DispatchQueue.main.async {
                    error?(ErrorViewModel(error: err))
                    self.isUserFriendly = err.isUserFriendlyMessage ?? false
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
        return productImagesList.count
    }
    
    func getImages(position : Int) -> ProductImageModel? {
        return productImagesList[position]
    }
    
    func getImageArray() -> [ProductImageModel]? {
        return productImagesList
    }
    
    func getBrandImage() -> String? {
        productDetailModel?.brand?.icon?.normal
    }
    
    func isOutofStock() -> Bool {
        return productDetailModel?.stock == 0
    }
    
    func isShippingFree() -> Bool {
        return (!(isUseFixPrice()) && productDetailModel?.shippingPrice == 0.0)
    }
    
    func isUseFixPrice() -> Bool {
        return (productDetailModel?.useFixPrice == true && productDetailModel?.shippingPrice == 0)
    }
    
    func hasDiscount() -> Bool {
        return productDetailModel?.campaignPrice != nil && productDetailModel?.campaignPrice != 0
    }
    
    func getCurrency() -> String {
        return productDetailModel?.currency?.currencySymbol ?? ""
    }
    
    func getShippingPrice() -> String {
        return String(productDetailModel?.shippingPrice ?? 0.0)
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
    
    func getStockCount() -> Int {
        return productDetailModel?.stock ?? 0
    }
    
    func isProductReachMaximumAddLimit() -> Bool {
        return productDetailModel?.maxQuantityPerOrder == quantityCount || productDetailModel?.stock == quantityCount
    }
    
    func getMaxQuantityCount() -> String {
        return productDetailModel?.maxQuantityPerOrder?.description ?? ""
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
        return SRAppContext.aliasKey
    }
    
    func getReturnExchangePopUpViewModel() -> PopUpViewModel {
        return PopUpViewModel(image: .deliveryTerms, title: getCancellationProdecureTitle(), description: nil , firstButton: PopUpButtonModel(title: "e_commerce_product_detail_terms_delivery_conditions_popup_button".localized, type: .lightButton), secondButton: nil, htmlDescription: getReturnExchangeTerms()?.convertHtml())
    }
    
    func getDeliveryTermsPopUpViewModel() -> PopUpViewModel {
        return PopUpViewModel(image: .deliveryTerms, title: getDeliveryConditionsTitle(), description: nil , firstButton: PopUpButtonModel(title: "e_commerce_product_detail_terms_delivery_conditions_popup_button".localized, type: .lightButton), secondButton: nil, htmlDescription :  getDeliveryTerms()?.convertHtml())
    }
    
    func getSoldOutPopUpViewModel() -> PopUpViewModel {
        isPopUpState = true
        return PopUpViewModel(image: .outOfStock, title: "e_commerce_product_detail_out_of_stock_title".localized, description: "e_commerce_product_detail_out_of_stock_description".localized , firstButton: PopUpButtonModel(title: "e_commerce_product_detail_out_of_stock_button".localized, type: .lightButton), secondButton: nil)
    }
    
    func getMaxQuantityPopUpViewModel() -> PopUpViewModel {
        return PopUpViewModel(image: .outOfStock, title: "e_commerce_product_detail_maximum_product_limit_title".localized, description: String(format: "e_commerce_product_detail_maximum_product_limit_description".localized, "\(productDetailModel?.maxQuantityPerOrder ?? 0)") , firstButton: PopUpButtonModel(title: "e_commerce_product_detail_terms_delivery_conditions_popup_button".localized, type: .lightButton), secondButton: nil)
    }
    
    func getProductNotFoundPopUpViewModel() -> PopUpViewModel {
        return PopUpViewModel(image: .outOfStock, title: "e_commerce_product_detail_not_found_product_title".localized, description: "e_commerce_product_detail_not_found_product_description".localized, firstButton: nil, secondButton: PopUpButtonModel(title: "e_commerce_general_ok_button_text".localized, type: .darkButton))
    }
    
    func isStateSoldOut() -> Bool {
        return isPopUpState
    }
    
    func isUserFriendlyMessage() -> Bool {
        return self.isUserFriendly
    }
    
    func getDeliveryConditionsTitle() -> String {
        if let deliveryConditionTitle = paymentSettings?.deliveryConditionsTitle ,
        deliveryConditionTitle != "" {
            return deliveryConditionTitle
        } else {
            return "e_commerce_product_detail_delivery_conditions".localized
        }
    }
    
    func getCancellationProdecureTitle() -> String {
        if let cancellationProdecureTitle = paymentSettings?.cancellationProcedureTitle ,
        cancellationProdecureTitle != "" {
            return cancellationProdecureTitle
        } else {
            return "e_commerce_product_detail_return_terms".localized
        }
    }
    
    func getVariantFields() -> [SRTextField] {
        var textFields : [SRTextField] = [SRTextField]()
        if let variationGroups = variationGroups {
            for (index,variations) in variationGroups.enumerated() {
                let textFld = SRTextField()
                textFld.getTextField().backgroundColor = .buttonLight
                textFld.setup(rightViewImage: UIImage(systemName: "chevron.down"), type: .withNoPadding)
                textFld.isEnabled = false
                textFld.getTextField().text = variations.name
                textFld.tag = index
                textFields.append(textFld)
            }
            return textFields
        }
        return [SRTextField]()
    }
    
    func getVariantList(index: Int) -> [Variation]? {
        return variationGroups?[index].variations
    }
    
    func isVariantEmpty() -> Bool {
        guard let variationGroups = variationGroups else {
            return false
        }
        return variationGroups.isEmpty
    }
    
    private func setVariantListVariables() {
        guard let variantsList = variantsList else {
            return
        }
        productImagesList.append(contentsOf: productDetailModel?.images ?? [ProductImageModel]())
        for variants in variantsList {
            productImagesList.append(contentsOf: variants.images ?? [ProductImageModel]())
        }
    }
    
}
