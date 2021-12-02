//
//  FilterModel.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 30.11.2021.
//

import Foundation

struct FilterModel {
    var categoryIds: [String] = []
    var brandIds: [String] = []
    var variationGroups: [VariationIds] = []
    var minimumPrice: Double?
    var maximumPrice: Double?
    var showCaseId: String? = nil
}

struct VariationIds {
    let variationGroupsItemId: String?
    var variationIds: [String] = []
}
