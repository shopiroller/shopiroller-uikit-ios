//
//  SelectionPopUpModel.swift
//  Shopiroller
//
//  Created by Görkem Gür on 10.03.2022.
//

import Foundation


struct SelectionPopUpModel {
    let datalist: [Any]?
    let selectionType: SelectionType?
}

enum SelectionType {
    case country,
         district,
         state
}
