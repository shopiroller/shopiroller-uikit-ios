//
//  SRSessionManager.swift
//  FittedSheets
//
//  Created by Görkem Gür on 17.11.2021.
//

import Foundation

class SRSessionManager {
    
    static var shared = SRSessionManager()
    
    var userBillingAddress : UserBillingAdressModel?
    
    var userShippingAddress: UserShippingAddressModel?
    
    var makeOrder : SRMakeOrderResponse?
    
    
    
}
