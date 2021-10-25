//
//  OrderDetailModel.swift
//  shopiroller
//
//  Created by Görkem Gür on 20.09.2021.
//

import Foundation


class OrderDetailModel: SROrderModel {
    
    var bankAccount: String?
    var paymentAccount: BankAccountModel?
    var shippingAdress: MakeOrderAddressModel?
    var billingAdress: MakeOrderAddressModel?
    var buyer: BuyerOrderModel?
    
    func getFullName() -> String? {
          return  (buyer?.name ?? "") +  (buyer?.surname ?? "")
    }
    
}
