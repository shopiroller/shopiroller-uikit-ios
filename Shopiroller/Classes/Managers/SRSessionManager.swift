//
//  SRSessionManager.swift
//  FittedSheets
//
//  Created by Görkem Gür on 17.11.2021.
//

import Foundation

class SRSessionManager {
    static var shared = SRSessionManager()
    
    var orderEvent: OrderPaymentEvent = OrderPaymentEvent()
    
    var userBillingAddress: UserBillingAdressModel?
    
    var userDeliveryAddress: UserShippingAddressModel?

    var paymentSettings : PaymentSettingsResponeModel?
    
    var orderResponseInnerModel : SROrderResponseInnerModel?
    
    var makeOrder : SRMakeOrderResponse?
    
}
