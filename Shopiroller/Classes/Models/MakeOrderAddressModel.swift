//
//  MakeOrderAdressModel.swift
//  shopiroller
//
//  Created by Görkem Gür on 19.09.2021.
//

import Foundation

struct MakeOrderAddressModel: Codable {
    
    var id: String?
    var city: String?
    var country: String?
    var state: String?
    var description: String?
    var zipCode: String?
    var identityNumber: String?
    var companyName: String?
    var taxNumber: String?
    var phoneNumber: String?
    var taxOffice: String?
    var nameSurname: String?
    
    func getDescriptionArea() -> String {
        return [ description
                , String.NEW_LINE
                , city
                , " / " , state , " / " , country
                , String.NEW_LINE
                , "%@"
                , " - "
                , phoneNumber].compactMap { $0 }
                .joined(separator: " ")
    }
    
    func getBillingDescriptionArea() -> String {
        if (taxOffice != nil && taxOffice != ""){
            return [ description
            , String.NEW_LINE
            , city
            , " / " , state , " / " , country
            , String.NEW_LINE
            , "%@"
            , " - "
            , phoneNumber
            , String.NEW_LINE
            , taxOffice , " - " , taxNumber].compactMap { $0 }
            .joined(separator: " ")}
        else{
            return [ description
            , String.NEW_LINE
            , city
            , " / " , state , " / " , country
            , String.NEW_LINE
            , "%@"
            , " - "
            , phoneNumber
            , String.NEW_LINE
            , identityNumber].compactMap { $0 }
            .joined(separator: " ")}
    }
}

