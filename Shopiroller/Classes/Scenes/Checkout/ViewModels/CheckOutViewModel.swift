//
//  CheckOutViewModel.swift
//  Shopiroller
//
//  Created by Görkem Gür on 1.11.2021.
//

import Foundation


class CheckOutViewModel {
    
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
    
    func getCurrentStep() -> ProgressStageEnum {
        return progressStage
    }
    
    func setCurrentStep(_ stage: ProgressStageEnum) {
        self.progressStage = stage
    }
    
    
}

enum ProgressStageEnum {
    case address
    case payment
    case info
}
