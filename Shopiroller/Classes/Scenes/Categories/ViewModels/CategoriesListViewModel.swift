//
//  CategoriesListViewModel.swift
//  Shopiroller
//
//  Created by Görkem Gür on 22.10.2021.
//

import Foundation
import UIKit


class CategoriesListViewModel : BaseViewModel {
    
    var categoryList : [SRCategoryResponseModel]?
    
    var isSubCategory: Bool? = false
    
    var title: String? = ""
         
    init(categoryList : [SRCategoryResponseModel]? = [SRCategoryResponseModel]() , isSubCategory: Bool? = false){
        self.categoryList = categoryList
        self.isSubCategory = isSubCategory
    }
    
    func getModel() -> [SRCategoryResponseModel]? {
        // Sort categories By Name
        categoryList?.sort() { $0.name ?? "" < $1.name ?? "" }
        // Do not show if there is 0 product categories
        categoryList = categoryList?.filter { $0.totalProduct != 0 }
        return categoryList
    }
    
    
    func hasSubCategory(position: Int) -> Bool {
        if categoryList?[position].subCategories != nil , !(categoryList?[position].subCategories?.isEmpty ?? false) {
            return true
        }else {
            return false
        }
    }
    
    func getCategoryTitle(position: Int) -> String? {
        return categoryList?[position].name
    }
    
    func getTitle() -> String? {
        return title
    }
    
}
