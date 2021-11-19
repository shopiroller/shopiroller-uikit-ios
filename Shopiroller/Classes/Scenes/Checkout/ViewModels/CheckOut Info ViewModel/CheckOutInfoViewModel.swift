//
//  CheckOutInfoViewModel.swift
//  Shopiroller
//
//  Created by Görkem Gür on 1.11.2021.
//

import Foundation


class CheckOutInfoViewModel: BaseViewModel {
    private var shoppingCart: SRShoppingCartResponseModel?

    
    
    func getShoppingCart(success: (() -> Void)? = nil , error: ((ErrorViewModel) -> Void)? = nil) {
        SRNetworkManagerRequests.getShoppingCart(userId: SRAppConstants.Query.Values.userId).response() {
            (result) in
            switch result {
            case .success(let result):
                self.shoppingCart = result.data
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
    
    func getUpdateCardPopUpModel() -> PopUpViewModel {
        return PopUpViewModel(image: UIImage(systemName: "pencil")!, title:  "checkout-info-update-order-pop-up-title".localized, description: "checkout-info-update-order-pop-up-description".localized, firstButton: PopUpButtonModel(title:   "checkout-info-update-order-pop-up-button-text".localized, type: .clearButton), secondButton: nil)
    }
}
