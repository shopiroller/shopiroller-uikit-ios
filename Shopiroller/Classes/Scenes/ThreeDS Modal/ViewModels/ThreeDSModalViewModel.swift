//
//  ThreeDSModalViewModel.swift
//  Shopiroller
//
//  Created by Emre Can Altaca on 8.11.2021.
//

import Foundation


class ThreeDSModalViewModel : BaseViewModel {
    
    private var urlToOpen: String?
    
    init(urlToOpen : String?) {
        self.urlToOpen = urlToOpen
    }
    
    func isPageFinished(url: String) -> Bool {
        if (url == SRAppConstants.URLResults.paymentSuccess) || (url == SRAppConstants.URLResults.paymentSuccess1) || (url == SRAppConstants.URLResults.paymentSuccess2) {
            SRSessionManager.shared.orderResponseInnerModel?.paymentResult?.isSuccess = true
        } else if (url == SRAppConstants.URLResults.paymentFailed) || (url == SRAppConstants.URLResults.paymentFailed1) || (url == SRAppConstants.URLResults.paymentFailed2) {
            SRSessionManager.shared.orderResponseInnerModel?.paymentResult?.isSuccess = false
            if let status = ECommerceUtil.urlContainsOf(url, queryParamaterName: "status") {
                SRSessionManager.shared.orderResponseInnerModel?.paymentResult?.status = status
            }
            return true
        }
        return false
    }
    
    func getRedirectUrl() -> String? {
        return urlToOpen
    }
}
