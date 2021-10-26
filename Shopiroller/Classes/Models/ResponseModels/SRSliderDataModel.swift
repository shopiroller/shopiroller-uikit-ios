//
//  SRSliderDataModel.swift
//  shopiroller
//
//  Created by Görkem Gür on 17.09.2021.
//

import Foundation

struct SRSliderDataModel: Codable {
    var name: String?
    var id: String?
    var createdDate: String?
    var updatedDate: String?
    var isActive: Bool?
    var slides: [SliderSlidesModel]?
    
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case id = "id"
        case isActive = "isActive"
        case createdDate = "createDate"
        case updatedDate = "updateDate"
        case slides = "slides"
    }
}

struct SliderSlidesModel: Codable {
    
    var imageUrl: String?
    var id: String?
    var orderIndex: Int?
    var createdDate: String?
    var updatedDate: String?
    var isActive: Bool?
    var navigationType: SliderNavigationType?
    var navigationLink: String?
    
    enum CodingKeys: String, CodingKey {
        case createdDate = "createDate"
        case updatedDate = "updateDate"
        case id = "id"
        case orderIndex = "orderIndex"
        case imageUrl = "imageUrl"
        case isActive = "isActive"
        case navigationType = "navigationType"
        case navigationLink = "navigationLink"
    }
    
}

enum SliderNavigationType: String, Codable {
    
    case web = "Web"
    case product = "Product"
    case category = "Category"
    case nothing = "None"
    
}

