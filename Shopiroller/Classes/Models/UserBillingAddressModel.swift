//
//  UserBillingAddressModel.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 25.10.2021.
//

import Foundation

class UserBillingAdressModel: BaseAddressModel {
    
    var type: String?
    var identityNumber: String?
    var companyName: String?
    var taxNumber: String?
    var taxOffice: String?
    
    enum CodingKeys: String,CodingKey {
        case type = "type"
        case identityNumber = "identityNumber"
        case companyName = "companyName"
        case taxNumber = "taxNumber"
        case taxOffice = "taxOffice"
    }
    
    func getOrderAdress() -> MakeOrderAddressModel {
        var makeOrderAddress = MakeOrderAddressModel()
        makeOrderAddress.city = city
        makeOrderAddress.companyName = companyName
        makeOrderAddress.state = state
        makeOrderAddress.country = country
        makeOrderAddress.description = description
        makeOrderAddress.id = id
        makeOrderAddress.identityNumber = identityNumber
        makeOrderAddress.taxOffice = taxOffice
        makeOrderAddress.taxNumber = taxNumber
        makeOrderAddress.zipCode = zipCode
        makeOrderAddress.phoneNumber = contact?.phoneNumber
        makeOrderAddress.nameSurname = contact?.nameSurname
        return makeOrderAddress
    }
    
    func getListBillingDescriptionArea() -> String {
        if(type?.caseInsensitiveCompare("Corporate") == ComparisonResult.orderedSame) {
            return [contact?.nameSurname
                    , String.NEW_LINE
                    , addressLine
                    , String.NEW_LINE
                    , city , " / " , state , " / " , country
                    , String.NEW_LINE
                    , contact?.phoneNumber
                    , String.NEW_LINE
                    , taxOffice , " - " , taxNumber].compactMap { $0 }
                    .joined(separator: " ")
        } else {
            return [contact?.nameSurname
                    , String.NEW_LINE
                    , addressLine
                    , String.NEW_LINE
                    , city , " / " , state , " / " , country
                    , String.NEW_LINE
                    , contact?.phoneNumber
                    , String.NEW_LINE
                    , identityNumber].compactMap { $0 }
                    .joined(separator: " ")
        }
    }
    
}

