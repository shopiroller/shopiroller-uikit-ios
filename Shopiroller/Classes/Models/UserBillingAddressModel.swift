//
//  UserBillingAddressModel.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 25.10.2021.
//

import Foundation

struct UserBillingAdressModel: Codable {
    
    var type: String?
    var identityNumber: String?
    var companyName: String?
    var taxNumber: String?
    var taxOffice: String?
    var id: String?
    var title: String?
    var country: String?
    var state: String?
    var city: String?
    var addressLine: String?
    var zipCode: String?
    var description: String?
    var isDefault: Bool?
    var contact: AddressContactModel?
    
    enum CodingKeys: String,CodingKey {
        case type = "type"
        case identityNumber = "identityNumber"
        case companyName = "companyName"
        case taxNumber = "taxNumber"
        case taxOffice = "taxOffice"
        case id = "id"
        case title = "title"
        case country = "country"
        case state = "state"
        case city = "city"
        case addressLine = "addressLine"
        case zipCode = "zipCode"
        case description = "description"
        case isDefault = "isDefault"
        case contact = "contact"
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
    
    func getListDeliveryDescriptionArea() -> String {
        return [contact?.nameSurname
                ,String.NEW_LINE
                ,addressLine
                ,String.NEW_LINE
                ,city , " / " , state , " / " , country
                ,String.NEW_LINE
                ,contact?.phoneNumber].compactMap { $0 }
                .joined(separator: "")
    }
    
    func getDescriptionArea() -> String {
        return [city
                , " / ", state , " / ", country
                , String.NEW_LINE
                , contact?.nameSurname
                , " - "
                , contact?.phoneNumber].compactMap { $0 }
                .joined(separator: "")
        
    }
    
    func getPopupAddressFirstLine() -> String  {
        return addressLine ?? ""
    }

    func getPopupAddressSecondLine() -> String {
        return [city
                , " / " , state
                , " / " , country].compactMap { $0 }
                .joined(separator: "")
    }
        

    func getPopupAddressThirdLine() -> String {
        return [contact?.nameSurname
                , " - " ,contact?.phoneNumber].compactMap { $0 }
                .joined(separator: "")
    }
    
    func getSummaryDescriptionArea () -> String {
        return [ addressLine
                 , " " , city
                 , " / " , state
                 , " " , contact?.nameSurname
                 , " - "
                 , contact?.phoneNumber].compactMap{ $0 }
                 .joined(separator: "")
    }
        
}

struct AddressContactModel: Codable {
    
    var nameSurname: String?
    var phoneNumber: String?
    var email: String?
    
    enum CodingKeys: String,CodingKey {
        case nameSurname = "nameSurname"
        case phoneNumber = "phoneNumber"
        case email = "email"
    }
}

