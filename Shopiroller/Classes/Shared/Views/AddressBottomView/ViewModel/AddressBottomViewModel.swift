//
//  AddressBottomViewModel.swift
//  Shopiroller
//
//  Created by Görkem Gür on 4.11.2021.
//

import Foundation

class AddressBottomViewModel: BaseViewModel {
    
    private var type: GeneralAddressType?
    
    init(type: GeneralAddressType? = nil){
        self.type = type
    }
    
}
