//
//  ShoppingCartPopUpViewModel.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 3.11.2021.
//

import Foundation

class ShoppingCartPopUpViewModel: SRBaseViewModel {
    
    private let productList: [ShoppingCartItem]?
    
    private var outOfStockCount = 0
    
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
        return String(format: "shopping_cart_validate_warning".localized, arguments: [String(changedProductCount()), String(outOfStockCount)])
    }
    
    private func changedProductCount() -> Int {
        var count = 0
        if let list = productList {
            for item in list {
                if(item.messages?[0].key == .UpdatedProduct || item.messages?[0].key == .NotEnoughStock){
                    count += 1
                }else if(item.messages?[0].key == .OutOfStock) {
                    outOfStockCount += 1
                }
            }
        }
        return count
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
