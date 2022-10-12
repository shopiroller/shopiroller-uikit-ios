//
//  SRDefaultAddressModel.swift
//  Shopiroller
//
//  Created by Görkem Gür on 4.11.2021.
//

import Foundation

class SRDefaultAddressModel: Codable {
    
    var shippingAddress : UserShippingAddressModel?
    var billingAddress : UserBillingAdressModel?
}
