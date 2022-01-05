//
//  SRGlobalRequestManager.swift
//  Shopiroller
//
//  Created by Görkem Gür on 20.10.2021.
//

import Foundation

class SRGlobalRequestManager {
    static func getShoppingCartCount(success: (() -> Void)? = nil, error: ((ErrorViewModel) -> Void)? = nil) {
        SRNetworkManagerRequests.getShoppingCartCount(userId: SRAppContext.userId).response() {
            (result) in
            switch result{
            case .success(let response):
                if let count = response.data {
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
                }
            }
        }
        
    }
}
