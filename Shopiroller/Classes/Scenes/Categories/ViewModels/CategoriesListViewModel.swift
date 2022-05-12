//
//  CategoriesListViewModel.swift
//  Shopiroller
//
//  Created by Görkem Gür on 22.10.2021.
//

import Foundation
import UIKit

class CategoriesListViewModel : SRBaseViewModel {
    
    private struct Constants {
        
        static var subCategoryContainerText: String { return "e_commerce_category_list_see_all_product_for_category".localized }
        
        static var categoriesPageTitle: String { return "e_commerce_category_list_categories_title".localized }
        
    }

    var categoryList : [SRCategoryResponseModel]?
    
    var isSubCategory: Bool? = false
    
    private var selectedRowName: String? = ""
    
    private var categoryId: String? = ""
    
    private var categoryDisplayTypeEnum: CategoryDisplayTypeEnum? = .imageAndText
         
    init(categoryList : [SRCategoryResponseModel]? = [SRCategoryResponseModel]() , isSubCategory: Bool? = false, selectedRowName: String? = String(), categoryId: String? = String(), categoryDisplayTypeEnum: CategoryDisplayTypeEnum? = .imageAndText){
        self.categoryList = categoryList
        self.isSubCategory = isSubCategory
        self.selectedRowName = selectedRowName
        self.categoryId = categoryId
        self.categoryDisplayTypeEnum = categoryDisplayTypeEnum
    }
    
    func getPageTitle() -> String? {
        return (isSubCategory == true) ? selectedRowName : Constants.categoriesPageTitle
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
        return String(format: Constants.subCategoryContainerText, selectedRowName ?? "")
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
    
    func getCategoryDisplayTypeEnum() -> CategoryDisplayTypeEnum? {
        return categoryDisplayTypeEnum ?? .imageAndText
    }
    
}
