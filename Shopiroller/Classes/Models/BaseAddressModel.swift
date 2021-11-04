//
//  BaseAddressModel.swift
//  shopiroller
//
//  Created by Görkem Gür on 19.09.2021.
//

import Foundation


class BaseAddressModel: Codable {
    
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


