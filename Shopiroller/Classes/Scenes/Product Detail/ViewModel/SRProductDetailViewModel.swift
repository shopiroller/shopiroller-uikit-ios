//
//  ProductDetailViewModel.swift
//  shopiroller
//
//  Created by Görkem Gür on 7.10.2021.
//

import UIKit
import Kingfisher
import AVFoundation

public class SRProductDetailViewModel: SRBaseViewModel {
    
    private var productId: String?
    private var productDetailModel: ProductDetailResponseModel?
    private var paymentSettings: PaymentSettingsResponeModel?
    private var variantData: [VariantDataModel]?
    private var variationGroups: [VariationGroups]?
    private var variantsList: [ProductDetailResponseModel]?
    private var productImagesList: [ProductImageModel] = [ProductImageModel]()
    private var variantImagesList: [ProductImageModel] = [ProductImageModel]()
    private var variantDataDictionary = [String : String]()
    private var pickerViewSelectedVariant = [Int : Int]()
    
    var quantityCount = 1
    private var selectedVariantGroupIndex = 0
    private var selectedVariantImageIndex = 0
    
    private var tempImageIndex = 0
    private var isPopUpState: Bool = false
    private var isUserFriendly: Bool = false
    private var textFields : [SRTextField] = [SRTextField]()
    private var stackViews = [UIStackView]()
    
    
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
        SRNetworkManagerRequests.addProductToShoppingCart(products: SRAddProductModel(productId: self.productId, quantity: self.quantityCount, displayName: productDetailModel?.title, userFullName: SRAppContext.userFullname, userEmail: SRAppContext.userEmail), userId: SRAppContext.userId).response() {
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
    
    func hasVideo() -> Bool {
        return !(productDetailModel?.videos?.isEmpty ?? true)
    }
    
    func getVideoUrl() -> URL? {
        if !(productDetailModel?.videos?.isEmpty ?? true), let urlString = productDetailModel?.videos?[0] {
            return URL(string: urlString)
        }
        return nil
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
    
    func getVariantDoesNotExistPopUpViewModel() -> PopUpViewModel {
        return PopUpViewModel(image: .outOfStock, title: "e_commerce_product_detail_does_not_exist_variant_error".localized, description: "e_commerce_product_detail_does_not_exist_variant_description".localized, firstButton: PopUpButtonModel(title: "e_commerce_product_detail_maximum_product_limit_button".localized, type: .lightButton), secondButton: nil)
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
    
    func getVariantFields() -> [UIStackView] {
        if let variationGroups = variationGroups {
            for (index,variations) in variationGroups.enumerated() {
                let textFld = SRTextField()
                textFld.getTextField().backgroundColor = .buttonLight
                textFld.setup(rightViewImage: UIImage(systemName: "chevron.down"), type: .withNoPadding)
                textFld.isEnabled = false
                textFld.getTextField().text = variations.variations?[0].value
                if let variation = variations.variations?[0] {
                    variantDataDictionary.updateValue(variation.value ?? "", forKey: variations.name ?? "")
                }
                textFld.tag = index
                textFields.append(textFld)
            }
            productDetailModel = variantsList?[0]
            productId = productDetailModel?.id ?? ""
            let stackViews = getStackViews()
            return stackViews
        }
        return [UIStackView]()
    }
    
    private func getStackViews() -> [UIStackView] {
        var isOdd = false
        if ((variationGroups?.count ?? 0) % 2 != 0) {
            isOdd = true
        }
        var stackView = UIStackView()
        for textField in textFields {
            if (stackView.subviews.count == 2) {
                stackView = UIStackView()
                stackView.addArrangedSubview(textField)
            }
            stackView.addArrangedSubview(textField)
            stackView.spacing = 20
            stackView.distribution = .fillEqually
            stackViews.append(stackView)
        }
        if(isOdd) {
            let emptyTextField = SRTextField()
            emptyTextField.setup(rightViewImage: nil, type: .emptyTextField)
            emptyTextField.isEnabled = false
            let lastStack = stackViews.last
            lastStack?.addArrangedSubview(emptyTextField)
            stackViews = stackViews.dropLast()
            stackViews.append(lastStack ?? UIStackView())
        }
        return stackViews
    }
    
    func setSelectedVariantTextFieldIndex(index: Int) {
        self.selectedVariantGroupIndex = index
    }
    
    func getSelectedVariantGroupIndex() -> Int {
        return self.selectedVariantGroupIndex
    }
    
    func getVariantListAt(index: Int) -> [Variation]? {
        return variationGroups?[index].variations
    }
    
    func getVariantListCountAt(index: Int) -> Int {
        return variationGroups?[index].variations?.count ?? 1
    }
    
    func getVariantValueAt(index: Int, variantGroupIndex: Int) -> String? {
        guard let variantValue = variationGroups?[variantGroupIndex].variations?[index].value else { return "" }
        return variantValue
    }
    
    func setSelectedVariantValue(index: Int, variantGroupIndex: Int) {
        if let selectedVariantValue = variationGroups?[variantGroupIndex].variations?[index].value {
            variantDataDictionary.updateValue(selectedVariantValue, forKey: variationGroups?[variantGroupIndex].name ?? "")
        }
    }
    
    func getImageIndexAtVariant(index: Int, variantGroupIndex: Int) -> Int {
        if let list = getSelectedVariantList() , !(list.isEmpty) {
            let model = list[0]
            productDetailModel = model
            productId = model.id
            let imageIndex = (getImageIndexOfVariant(variantModel: model))
            if imageIndex != -1 {
                tempImageIndex = imageIndex //+ productDetailImagesCount
            } else {
                return tempImageIndex
            }
        }
        return tempImageIndex
    }
    
    private func getSelectedVariantList() -> [ProductDetailResponseModel]? {
        var list = variantsList.map{ $0 }
        for (_,element) in variantDataDictionary.enumerated() {
            let variantId = getVariantIdFrom(variantName: element.key, variantValue: element.value)
            list = list?.filter {($0.variantData?.contains(where: { $0.variationId == variantId }) ?? false)}
        }
        return list
    }
    
    func isVariantCanBeAdded() -> Bool {
        if let variants = variantsList , !variants.isEmpty {
            if let list = getSelectedVariantList() , !(list).isEmpty {
                return true
            } else {
                return false
            }
        }
        return true
    }
    
    func getVariantIdFrom(variantName: String, variantValue: String) -> String? {
        var variationList = [Variation]()
        var variantId = ""
        if let variationGroupsList = variationGroups?.filter({ $0.name == variantName }) {
            variationGroupsList.forEach {
                variationList = $0.variations?.filter { $0.value == variantValue } ?? [Variation]()
            }
        }
        variationList.forEach {
            variantId = $0.id ?? ""
        }
        return variantId
    }
    
    func getIndexOfVariant(variantModel: ProductDetailResponseModel) -> Int {
        if let variantsList = variantsList {
            for (index,element) in variantsList.enumerated() {
                if element.id == variantModel.id {
                    return index
                }
            }
        }
        return 0
    }
    
    func getImageIndexOfVariant(variantModel: ProductDetailResponseModel) -> Int {
        if let variantsList = variantsList {
            let variantListWithImage = variantsList.filter{ $0.images?.count ?? 0 > 0}
            for (index,element) in variantListWithImage.enumerated() {
                if element.id == variantModel.id {
                    return index
                }
            }
        }
        return -1
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
//        productDetailImagesCount = productDetailModel?.images?.count ?? 0
        
        for variants in variantsList {
            variantImagesList.append(contentsOf: variants.images ?? [ProductImageModel]())
        }
        productImagesList.append(contentsOf: variantImagesList)
        productImagesList.append(contentsOf: productDetailModel?.images ?? [ProductImageModel]())
    }
    
    func getPickerViewModel(items: [UIBarButtonItem]?) -> PickerViewModel? {
        let pickerViewHeight = CGFloat(getVariantListCountAt(index: selectedVariantGroupIndex)) * 120
        return PickerViewModel(pickerViewHeight: pickerViewHeight, items: items)
    }
    
    func getPickerViewTitle() -> String? {
        return variationGroups?[selectedVariantGroupIndex].name ?? ""
    }
    
    func setSelectedVariantForPickerView(pickerViewIndex: Int) {
        pickerViewSelectedVariant.updateValue(pickerViewIndex, forKey: selectedVariantGroupIndex)
    }
    
    func getSelectedVariantIndexForPickerView() -> Int {
        if let variantIndex = pickerViewSelectedVariant[selectedVariantGroupIndex] {
            return variantIndex
        }
        return 0
    }
    
}

struct PickerViewModel {
    var pickerViewHeight: CGFloat?
    let items: [UIBarButtonItem]?
}

extension Array {
    func allSameForProperty<T:Equatable> (_ p:KeyPath<Element,T>) -> Bool {
        return self.isEmpty || self.allSatisfy{
            self.first![keyPath:p] == $0[keyPath:p]
        }
    }
}
