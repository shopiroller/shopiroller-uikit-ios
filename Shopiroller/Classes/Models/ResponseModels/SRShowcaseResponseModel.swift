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
    var products: [ProductDetailResponseModel]?
    var productCount: Int?

}

struct SRShowCaseModel: Codable {
    
    var name: String?
    var id: String?
    var createdAt: String?
    var status: String?
    var updatedAt: String?
    var publishmentDate: String?
    var isPublished: Bool?
    var orderIndex: Int?
    
    
    enum CodingKeys: String,CodingKey {
        case name = "name"
        case id = "id"
        case createdAt = "createAt"
        case status = "status"
        case updatedAt = "updateAt"
        case publishmentDate = "publishmentDate"
        case isPublished = "isPublished"
        case orderIndex = "orderIndex"
    }
}
