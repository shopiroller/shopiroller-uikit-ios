//
//  UserAddressViewModel.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 27.10.2021.
//

import Foundation

class UserAddressViewModel: BaseViewModel {
    
    
    func getShoppingCartCount(success: (() -> Void)? = nil, error: ((ErrorViewModel) -> Void)? = nil) {
        SRGlobalRequestManager.getShoppingCartCount(success: success, error: error)
    }
}
