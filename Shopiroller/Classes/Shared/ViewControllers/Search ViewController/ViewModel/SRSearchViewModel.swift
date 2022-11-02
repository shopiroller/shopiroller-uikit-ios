//
//  SearchViewModel.swift
//  Shopiroller
//
//  Created by Görkem Gür on 1.12.2021.
//

import Foundation

class SRSearchViewModel : SRBaseViewModel {
    
    private var _searchedKeyword: String?
    
    var searchedKeyword : String? {
        set {
            _searchedKeyword = newValue
        } get {
            return _searchedKeyword
        }
    }
}
