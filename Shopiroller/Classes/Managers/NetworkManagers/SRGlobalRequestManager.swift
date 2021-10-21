//
//  SRGlobalRequestManager.swift
//  Shopiroller
//
//  Created by Görkem Gür on 20.10.2021.
//

import Foundation

class SRGlobalRequestManager {
    static func getShoppingCartCount(success: (() -> Void)? = nil, error: ((ErrorViewModel) -> Void)? = nil) {
        SRNetworkManagerRequests.getShoppingCartCount(userId: "78971cc6-bda1-45a4-adee-638317c5a6e9").response(using: SRNetworkManager()) {
            (result) in
            switch result{
            case .success(let response):
                DispatchQueue.main.async {
                    SRAppContext.shoppingCartCount = response.data ?? 0
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
