//
//  FilterModel.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 30.11.2021.
//

import Foundation

struct FilterModel {
    var categoryIds: [FilterChoiceTableViewModel] = []
    var brandIds: [String] = []
    var minimumPrice: Double = 0.0
    var maximumPrice: Double = 0.0
    var showCaseId: String? = nil
}
