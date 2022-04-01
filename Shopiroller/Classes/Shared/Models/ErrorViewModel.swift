//
//  ErrorViewModel.swift
//  shopiroller
//
//  Created by Görkem Gür on 26.09.2021.
//

class ErrorViewModel: Error {
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
    
    static func validationError(message: String) -> ErrorViewModel {
        return ErrorViewModel(error: ShopirollerError.validation(description: message))
    }
    
}

extension ErrorViewModel {
    static let serverSide = ErrorViewModel(error: ShopirollerError.network)
}
