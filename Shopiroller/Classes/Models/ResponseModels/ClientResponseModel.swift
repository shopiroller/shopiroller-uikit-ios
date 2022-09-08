//
//  ClientResponseModel.swift
//  Shopiroller
//
//  Created by Abdullah Yalçın on 18.08.2022.
//

import Foundation

struct ClientResponseModel: Codable {
    let type, accountName, title: String?
    let properties: Properties?
    let id, createDate, updateDate: String?
}

struct Properties: Codable {
    let accountNumber, apiKey, countryPhoneCode: String?
    let eCommerceButton, isOnline, whatsAppMobileIsActive, whatsAppWebIsActive: Bool?
}
