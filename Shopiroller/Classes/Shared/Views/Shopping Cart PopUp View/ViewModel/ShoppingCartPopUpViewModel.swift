//
//  ShoppingCartPopUpViewModel.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 3.11.2021.
//

import Foundation

class ShoppingCartPopUpViewModel: BaseViewModel {
    
    private let productList: [ShoppingCartItem]?
    
    init(productList: [ShoppingCartItem]?) {
        self.productList = productList
    }
    
    func getTitle() -> String {
        return "Cart is updating".localized
    }
    
    func getDescription() -> String {
        return  "shopping_cart_validate_description".localized
    }
    
    func getWarning() -> String {
        return  "shopping_cart_validate_warning".localized
    }
    
    func getButtonTitle() -> String {
        return "shopping_cart_validate_ready_checkout".localized
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
