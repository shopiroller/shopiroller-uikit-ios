//
//  SRShowcaseResponseModel.swift
//  shopiroller
//
//  Created by Görkem Gür on 17.09.2021.
//

import Foundation


struct SRShowcaseResponseModel: Codable {
    
    var showcase: SRShowCaseModel?
    var showcaseType: String?
    var products: ProductDetailResponseModel?

}

struct SRShowCaseModel: Codable {
    var name: String?
    var id: String?
    var createdAt: String?
    var updatedAt: String?
    var isActive: Bool?
    
    
    enum CodingKeys: String,CodingKey {
        case name = "name"
        case id = "id"
        case createdAt = "createAt"
        case updatedAt = "updateAt"
        case isActive = "isActive"
    }
}
