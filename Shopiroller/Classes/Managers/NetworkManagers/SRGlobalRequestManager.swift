//
//  SRGlobalRequestManager.swift
//  Shopiroller
//
//  Created by Görkem Gür on 20.10.2021.
//

import Foundation

class SRGlobalRequestManager {
    static func getShoppingCartCount(success: (() -> Void)? = nil, error: ((ErrorViewModel) -> Void)? = nil) {
        SRNetworkManagerRequests.getShoppingCartCount(userId: SRAppConstants.Query.Values.userId).response() {
            (result) in
            switch result{
            case .success(let response):
                SRAppContext.shoppingCartCount = response.data ?? 0
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
}
