//
//  UserAddressViewModel.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 27.10.2021.
//

import Foundation

public class SRUserAddressViewModel: SRBaseViewModel {
    
    func getShoppingCartCount(success: (() -> Void)? = nil, error: ((ErrorViewModel) -> Void)? = nil) {
        SRGlobalRequestManager.getShoppingCartCount(success: success, error: error)
    }
}
