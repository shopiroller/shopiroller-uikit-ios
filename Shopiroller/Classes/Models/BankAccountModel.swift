//
//  BankAccountModel.swift
//  shopiroller
//
//  Created by Görkem Gür on 17.09.2021.
//

import Foundation


struct BankAccountModel: Codable {
    
    var accountAddress: String?
    var accountNumber: String?
    var accountCode: String?
    var accountName: String?
    var name: String?
    var nameSurname: String?
    
    var isSelected: Bool?
    
    var accountToString: String? {
        return (name ?? "") + " " + (accountName ?? "") + " " + (accountCode ?? "") + " " + (accountNumber ?? "")
    }
    
    enum CodingKeys: String,CodingKey {
        case accountAddress = "accountAddress"
        case accountNumber = "accountNumber"
        case accountCode = "accountCode"
        case accountName = "accountName"
        case name = "name"
        case nameSurname = "nameSurname"
        
    }
}
