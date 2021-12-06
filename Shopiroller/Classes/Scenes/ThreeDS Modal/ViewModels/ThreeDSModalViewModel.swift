//
//  ThreeDSModalViewModel.swift
//  Shopiroller
//
//  Created by Emre Can Altaca on 8.11.2021.
//

import Foundation


class ThreeDSModalViewModel : BaseViewModel {
    
    private var urlToOpen: String?
    
    private var message: String?
    
    init(urlToOpen : String?) {
        self.urlToOpen = urlToOpen
    }
    
    func isPageFinished(url: String) -> Bool {
        if (url.contains(SRAppConstants.URLResults.paymentSuccess)) || (url.contains( SRAppConstants.URLResults.paymentSuccess1 )) || (url.contains( SRAppConstants.URLResults.paymentSuccess2 )) || (url.contains(SRAppConstants.URLResults.paymentFailed)) || (url.contains( SRAppConstants.URLResults.paymentFailed1)) || (url.contains( SRAppConstants.URLResults.paymentFailed2))  {
             
            if (url.contains(SRAppConstants.URLResults.paymentSuccess)) || (url.contains( SRAppConstants.URLResults.paymentSuccess1 )) || (url.contains( SRAppConstants.URLResults.paymentSuccess2 )) {
                SRSessionManager.shared.orderResponseInnerModel?.payment?.isSuccess = true
            }
            
            if (url.contains(SRAppConstants.URLResults.paymentFailed)) || (url.contains( SRAppConstants.URLResults.paymentFailed1)) || (url.contains( SRAppConstants.URLResults.paymentFailed2)) {
                SRSessionManager.shared.orderResponseInnerModel?.payment?.isSuccess = false
                if let queryItems = URLComponents(string: url)?.queryItems {
                    let param1 = queryItems.filter({$0.name == "status"}).first
                    self.message = param1?.description
                }
            }
            
            return true
        } else {
            return false
        }
    }
    
    func getRedirectUrl() -> String? {
        return urlToOpen
    }
    
    func getErrorMessage() -> String? {
        return message
    }
}
