//
//  ShoppingCardViewModel.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 1.11.2021.
//

import Foundation


class ShoppingCartViewModel: SRBaseViewModel {
    
    private var shoppingCart: SRShoppingCartResponseModel?
    var campaignMessage: String?
    var indexAtRow: Int?
    
    func getShoppingCart(success: (() -> Void)? = nil , error: ((ErrorViewModel) -> Void)? = nil) {
        SRNetworkManagerRequests.getShoppingCart(userId: SRAppContext.userId).response() {
            (result) in
            switch result {
            case .success(let result):
                self.shoppingCart = result.data
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
    
    func clearShoppingCart(success: (() -> Void)? = nil , error: ((ErrorViewModel) -> Void)? = nil) {
        SRNetworkManagerRequests.clearShoppingCart(userId: SRAppContext.userId).response() {
            (result) in
            switch result {
            case .success(_):
                self.shoppingCart = nil
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
    
    func removeItemFromShoppingCart(itemId: String?, success: (() -> Void)? = nil , error: ((ErrorViewModel) -> Void)? = nil) {
        guard let id = itemId else { return }
        SRNetworkManagerRequests.removeItemFromShoppingCart(userId: SRAppContext.userId, cartItemId: id).response() {
            (result) in
            switch result {
            case .success(_):
                self.getShoppingCart(success: success, error: error)
            case .failure(let err):
                DispatchQueue.main.async {
                    error?(ErrorViewModel(error: err))
                }
            }
        }
    }
    
    func updateItemQuantity(itemId: String?, quantity: Int?, success: (() -> Void)? = nil , error: ((ErrorViewModel) -> Void)? = nil) {
        guard let id = itemId else { return }
        SRNetworkManagerRequests.updateItemQuantity(userId: SRAppContext.userId, cartItemId: id, body: UpdateCartItemQuantity(amount: quantity)).response() {
            (result) in
            switch result {
            case .success(_):
                self.getShoppingCart(success: success, error: error)
            case .failure(let err):
                DispatchQueue.main.async {
                    error?(ErrorViewModel(error: err))
                }
            }
        }
    }
    
    func validateShoppingCart(success: (() -> Void)? = nil , error: ((ErrorViewModel) -> Void)? = nil) {
        SRNetworkManagerRequests.validateShoppingCart(userId: SRAppContext.userId).response() {
            (result) in
            switch result {
            case .success(let result):
                self.shoppingCart = result.data
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
    
    func isShoppingCartEmpty() -> Bool {
        return shoppingCart?.items?.isEmpty ?? true
    }
    
    func getEmptyModel() -> EmptyModel {
        return EmptyModel(image: .emptyShoppingCart, title: "e_commerce_shopping_cart_empty_view_title".localized, description: "e_commerce_shopping_cart_empty_view_description".localized, button: ButtonModel(title: "e_commerce_general_start_shopping_button_text".localized, color: .textPrimary))
    }
    
    func getItemCountText() -> String {
        return String(format: "e_commerce_shopping_cart_item_count".localized, String(shoppingCart?.items?.count ?? 0) as CVarArg)
    }
    
    func getBottomPriceModel() -> BottomPriceModel {
        return BottomPriceModel(subTotalPrice: shoppingCart?.subTotalPrice, shippingPrice: shoppingCart?.shippingPrice, totalPrice: shoppingCart?.totalPrice, currency: shoppingCart?.currency)
    }

    func hasCampaign() -> Bool {
        if let messages = shoppingCart?.messages, !messages.isEmpty {
            for item in messages {
                if(item.type?.caseInsensitiveCompare(SRAppConstants.ShoppingCart.shoppingCartMessageType) == ComparisonResult.orderedSame) {
                    campaignMessage = item.message
                    return true
                }
            }
        }
        return false
    }
    
    func shoppingItemCount() -> Int {
        return shoppingCart?.items?.count ?? 0
    }
    
    func getShoppingCartItem(position : Int) -> ShoppingCartItem? {
        return shoppingCart?.items?[position]
    }
    
    func getClearCartPopUpViewModel() -> PopUpViewModel {
        return PopUpViewModel(image: .clearCart, title: "e_commerce_shopping_cart_clear_cart_title".localized, description: "e_commerce_shopping_cart_clear_cart_description".localized, firstButton: PopUpButtonModel(title: "e_commerce_dialog_negative_button".localized, type: .clearButton), secondButton: PopUpButtonModel(title: "e_commerce_shopping_cart_clear_cart_button".localized, type: .lightButton))
    }
    
    func hasInvalidItems() -> Bool {
        return shoppingCart?.invalidItems?.count ?? 0 > 0
    }
    
    func geShoppingCartPopUpViewModel() -> ShoppingCartPopUpViewModel {
        return ShoppingCartPopUpViewModel(productList: shoppingCart?.invalidItems)
    }
    
    
}
