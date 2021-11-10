//
//  EditAddressModel.swift
//  Shopiroller
//
//  Created by Görkem Gür on 8.11.2021.
//

import Foundation

struct EditAddressModel: Codable {
    var apiKey: String?
    var appKey: String?
    var country: String?
    var state: String?
    var city: String?
    var addressLine: String?
    var zipCode: String?
    var description: String?
    var title: String?
    var nameSurname: String?
    var phone: String?
    var email: String?
    var taxNumber: String?
    var companyName: String?
    var taxOffice: String?
    var identityNumber: String?
    var type: String?
    var id: String?
}
