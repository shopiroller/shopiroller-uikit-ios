//
//  ShoppingCartPopUpViewModel.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 3.11.2021.
//

import Foundation

class ShoppingCartPopUpViewModel: SRBaseViewModel {
    
    private struct Constants {
        
        static var updateShoppingCartTitle: String { return "e_commerce_shopping_cart_updating_popup_title".localized }
        static var updateShoppingCartDescription: String { return "e_commerce_shopping_cart_updating_popup_description".localized }
        static var updateShoppingCartButton: String { return "e_commerce_shopping_cart_invalid_popup_button".localized }

    }
    
    private let productList: [ShoppingCartItem]?
    
    private var outOfStockCount = 0
    
    init(productList: [ShoppingCartItem]?) {
        self.productList = productList
    }
    
    func getTitle() -> String {
        return Constants.updateShoppingCartTitle
    }
    
    func getDescription() -> String {
        return Constants.updateShoppingCartDescription
    }
    
    private func changedProductCount() -> Int {
        var count = 0
        if let list = productList {
            for item in list {
                if(item.messages?[0].key == .UpdatedProduct || item.messages?[0].key == .NotEnoughStock) {
                    count += 1
                }else if(item.messages?[0].key == .OutOfStock) {
                    outOfStockCount += 1
                }
            }
        }
        return count
    }
    
    func getButtonTitle() -> String {
        return Constants.updateShoppingCartButton
    }
    
    func getProductListCount() -> Int {
        return productList?.count ?? 0
    }
    
    func getProduct(position: Int) -> ShoppingCartItem? {
        return productList?[position]
    }
    
    func getTableViewMultiplier() -> CGFloat {
        if(getProductListCount() > 4) {
            return 450
        }else {
            return CGFloat(getProductListCount()) * 95
        }
    }
    
}
