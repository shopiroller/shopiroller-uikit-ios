//
//  UserShippingAddressModel.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 25.10.2021.
//

import Foundation

struct UserShippingAddressModel: Codable {
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
    
    func getOrderAdress() -> MakeOrderAddressModel{
        var makeOrderAddress = MakeOrderAddressModel()
        makeOrderAddress.city = city
        makeOrderAddress.state = state
        makeOrderAddress.country = country
        makeOrderAddress.description = description
        makeOrderAddress.id = id
        makeOrderAddress.zipCode = zipCode
        makeOrderAddress.phoneNumber = contact?.phoneNumber
        makeOrderAddress.nameSurname = contact?.nameSurname
        return makeOrderAddress
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
                ," / " , state
                ," / " ,country
                , contact?.phoneNumber].compactMap { $0 }
                .joined(separator: "")
    }
        

    func getPopupAddressThirdLine() -> String {
        return [contact?.nameSurname
                ," - " , contact?.phoneNumber
                ,contact?.phoneNumber].compactMap { $0 }
                .joined(separator: "")
    }
}
