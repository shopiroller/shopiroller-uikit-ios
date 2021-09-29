//
//  ShopirollerErrorModel.swift
//  shopiroller
//
//  Created by Görkem Gür on 22.09.2021.
//

import Foundation


class ShopirollerErrorModel {
    let error: ShopirollerError
    
    init(error: ShopirollerError) {
        self.error = error
    }
    
    var title: String {
        return error.title
    }
    
    var message: String {
        return error.localizedDescription
    }
    
    static func validationError(message: String) -> ShopirollerErrorModel {
        return ShopirollerErrorModel(error: ShopirollerError.validation(description: message))
    }
    
}

extension ShopirollerErrorModel {
    
    static let serverSide = ShopirollerErrorModel(error: ShopirollerError.network)
    
    
}

