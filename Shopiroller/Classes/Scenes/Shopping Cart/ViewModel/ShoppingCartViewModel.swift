//
//  ShoppingCardViewModel.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 1.11.2021.
//

import Foundation


class ShoppingCartViewModel: BaseViewModel {
    
    private var shoppingCart: SRShoppingCartResponseModel?
    var campaignMessage: String?
    
    func getShoppingCart(success: (() -> Void)? = nil , error: ((ErrorViewModel) -> Void)? = nil) {
        SRNetworkManagerRequests.getShoppingCart(userId: SRAppConstants.Query.Values.userId).response() {
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
        return EmptyModel(image: .emptyShoppingCart, title: "shopping_cart_empty_title".localized, description: "shopping_cart_empty_description".localized, button: ButtonModel(title:     "shopping_cart_empty_button_title".localized, color: .textPrimary))
    }
    
    func getItemCountText() -> String {
        return String(format: "shopping_cart_item_count".localized, String(shoppingCart?.items?.count ?? 0) as CVarArg)
    }
    
    func getBottomPriceModel() -> BottomPriceModel {
        return BottomPriceModel(subTotalPrice: shoppingCart?.subTotalPrice, shippingPrice: shoppingCart?.shippingPrice, totalPrice: shoppingCart?.totalPrice, currency: shoppingCart?.currency)
    }

    func hasCampaign() -> Bool {
        if let messages = shoppingCart?.messages, !messages.isEmpty {
            for item in messages {
                if(item.type?.caseInsensitiveCompare("Campaign") == ComparisonResult.orderedSame){
                    campaignMessage = item.message
                    return true
                }
            }
        }
        return false
    }
    
    func shopingItemCount() -> Int {
        return shoppingCart?.items?.count ?? 0
    }
    
    func getShoppingCartItem(position : Int) -> ShoppingCartItem? {
        return shoppingCart?.items?[position]
    }
    
    
}
