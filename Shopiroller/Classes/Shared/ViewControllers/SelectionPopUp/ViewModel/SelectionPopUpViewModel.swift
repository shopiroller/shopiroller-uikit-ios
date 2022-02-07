//
//  SelectionPopUpViewModel.swift
//  Shopiroller
//
//  Created by Görkem Gür on 7.11.2021.
//

import Foundation


class SelectionPopUpViewModel: SRBaseViewModel {
    
    var isSearching : Bool = false
    private var selectionList: [CountryModel]
    private var filteredList: [CountryModel] = []
    
    private var type: SelectionType?
    private var stateModel : CountryModel?
    private var countryModel: CountryModel?
    private var citiesModel: CountryModel?
    
    init(selectionList: [CountryModel] = [CountryModel]() , type: SelectionType? = .country){
        self.selectionList = selectionList
        self.type = type
    }
    
    func getItemCount() -> Int {
        return isSearching ? filteredList.count : selectionList.count
    }
    
    func getCellModel(position: Int) -> CountryModel {
        return isSearching ? filteredList[position] : selectionList[position]
        
    }
    
    func getType() -> SelectionType? {
        return type
    }
    
    func filterContentForSearchText(searchText: String) {
        filteredList = selectionList.filter { $0.name?.lowercased().contains(searchText.lowercased()) as! Bool }
    }
 
}


