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
    }
    
    private var progressStage: ProgressStageEnum = .address
    
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
    
    func getResultPageModel(isCreditCard: Bool) -> SRResultViewControllerViewModel {
        if isCreditCard {
            if SRSessionManager.shared.orderResponseInnerModel?.paymentResult?.isSuccess == true {
                return getResultPageSuccessModel()
            } else {
                return getResultPageFailModel()
            }
        } else {
            return getResultPageSuccessModel()
        }
        
    }
    
    private func getResultPageFailModel() -> SRResultViewControllerViewModel {
        return SRResultViewControllerViewModel(type: .fail, orderResponse: SRSessionManager.shared.orderResponseInnerModel)
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
