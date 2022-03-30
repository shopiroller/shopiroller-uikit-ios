//
//  CheckOutViewModel.swift
//  Shopiroller
//
//  Created by Görkem Gür on 1.11.2021.
//

import Foundation


class CheckOutViewModel {
    
    private var currentStage : ProgressStageEnum?
    
    init(currentStage: ProgressStageEnum? = .address){
        self.currentStage = currentStage
        self.getShoppingCart()
    }
    
    private var progressStage: ProgressStageEnum = .address
    
    var shoppingCart: SRShoppingCartResponseModel?
    
    var stripeOrderStatusModel = SRStripeOrderStatusModel()
    
    var errorMessage: String?
    
    func getPageTitle() -> String? {
        switch progressStage {
        case .payment:
            return "payment-information-page-title".localized
        case .info:
            return "info-information-page-title".localized
        case .address:
            return "delivery-information-page-title".localized
            
        }
    }
    
    func getCurrentStage() -> ProgressStageEnum? {
        return currentStage
    }
    
    func getResultPageModel(isSuccess: Bool) -> SRResultViewControllerViewModel {
        if (isSuccess){
            return getResultPageSuccessModel()
        } else {
            return getResultPageFailModel()
        }
    }
    
    func getShoppingCart(success: (() -> Void)? = nil , error: ((ErrorViewModel) -> Void)? = nil) {
        SRNetworkManagerRequests.getShoppingCart(userId: SRAppContext.userId,showProgress: false).response() {
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
    
    func setStripeFailRequest(success: (() -> Void)? = nil , error: ((ErrorViewModel) -> Void)? = nil) {
        SRNetworkManagerRequests.failurePayment(stripeOrderModel: stripeOrderStatusModel).response() {
            (result) in
            switch result {
            case .success(let response):
                print(response)
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
    
    func setStripeSuccessRequest(success: (() -> Void)? = nil , error: ((ErrorViewModel) -> Void)? = nil) {
        SRNetworkManagerRequests.completePayment(stripeOrderModel: stripeOrderStatusModel).response() {
            (result) in
            switch result {
            case .success(let response):
                print(response)
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
    
    private func getResultPageFailModel() -> SRResultViewControllerViewModel {
        return SRResultViewControllerViewModel(type: .fail, orderResponse: SRSessionManager.shared.orderResponseInnerModel,errorMessage: errorMessage != nil ? errorMessage : "")
    }
    
    private func getResultPageSuccessModel() -> SRResultViewControllerViewModel {
        return SRResultViewControllerViewModel(type: .success, orderResponse: SRSessionManager.shared.orderResponseInnerModel)
    }
    
}

enum ProgressStageEnum {
    case address
    case payment
    case info
}
