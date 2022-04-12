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
    case adress(SelectionAdressType)
    case variant
    
    
    enum SelectionAdressType {
        case country
        case district
        case state
    }
    
}
