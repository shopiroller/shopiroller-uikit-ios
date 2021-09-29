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
    var adressLine: String?
    var zipCode: String?
    var description: String?
    var isDefault: Bool?
    var contact: AddressContactModel?
    var isSelected: Bool?
    
    enum CodingKeys: String,CodingKey {
        case id = "id"
        case title = "title"
        case country = "country"
        case state = "state"
        case city = "city"
        case adressLine = "adressLine"
        case zipCode = "zipCode"
        case description = "description"
        case isDefault = "isDefault"
        case isSelected = "isSelected"
    }
    
}

struct AddressContactModel: Codable {
    
    var nameSurname: String?
    var phoneNumber: String?
    var email: String?
    
    enum CdoingKeys: String,CodingKey {
        case nameSurname = "nameSurname"
        case phoneNumber = "phoneNumber"
        case email = "email"
    }
}


