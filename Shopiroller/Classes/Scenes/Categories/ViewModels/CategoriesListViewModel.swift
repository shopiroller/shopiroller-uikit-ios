//
//  CategoriesListViewModel.swift
//  Shopiroller
//
//  Created by Görkem Gür on 22.10.2021.
//

import Foundation
import UIKit

class CategoriesListViewModel : BaseViewModel {
    
    private struct Constants {
        
        static var subCategoryContainerText: String { return "sub-category-container-text".localized }
        
    }

    var categoryList : [SRCategoryResponseModel]?
    
    var isSubCategory: Bool? = false
    
    private var selectedRowName: String? = ""
    
    private var categoryId: String? = ""
         
    init(categoryList : [SRCategoryResponseModel]? = [SRCategoryResponseModel]() , isSubCategory: Bool? = false, selectedRowName: String? = String(), categoryId: String? = String()){
        self.categoryList = categoryList
        self.isSubCategory = isSubCategory
        self.selectedRowName = selectedRowName
        self.categoryId = categoryId
    }
    
    func getPageTitle() -> String? {
        return (isSubCategory == true) ? selectedRowName : "category-page-title".localized
    }
    
    func getModel() -> [SRCategoryResponseModel]? {
       return categoryList
    }
    
    func hasSubCategory(position: Int) -> Bool {
        if categoryList?[position].subCategories != nil , !(categoryList?[position].subCategories?.isEmpty ?? false) {
            return true
        }else {
            return false
        }
    }
    
    func getTitle() -> String? {
        return Constants.subCategoryContainerText.replacingOccurrences(of: "XX", with: selectedRowName ?? "" )
    }
    
    func setSelectedRowName(position: Int) {
        self.selectedRowName = categoryList?[position].name
    }
    
    func setCategoryId(position: Int){
        self.categoryId = categoryList?[position].categoryId
    }
    
    func getCategoryId() -> String {
        return categoryId ?? ""
    }
    
    func getSelectedRowName() -> String? {
        return selectedRowName
    }
    
    func getShoppingCartCount(succes: (() -> Void)? = nil, error: ((ErrorViewModel) -> Void)? = nil) {
        SRGlobalRequestManager.getShoppingCartCount(success: succes, error: error)
    }
    
}
