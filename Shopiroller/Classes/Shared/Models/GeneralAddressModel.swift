//
//  GeneralAddressModel.swift
//  Shopiroller
//
//  Created by Görkem Gür on 3.11.2021.
//

import Foundation

struct GeneralAddressModel {
    let title: String?
    let address: String?
    let description: String?
    let type: GeneralAddressType?
    let isEmpty: Bool
}

enum GeneralAddressType {
    case shipping
    case billing
}
