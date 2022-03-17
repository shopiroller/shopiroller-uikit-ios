//
//  SRMainPageViewModel.swift
//  shopiroller
//
//  Created by Görkem Gür on 20.09.2021.
//

import UIKit

open class SRMainPageViewModel: SRBaseViewModel {
    
    private struct Constants {
        
        static var emptyViewTitle: String { return "empty-view-title".localized }
        
        static var emptyViewDescription: String { return "empty-view-description".localized }
        
    }
    
    private var sliderModel: [SRSliderDataModel]?
    private var categoriesWithOptions: SRCategoryResponseWithOptionsModel?
    private var products: [ProductDetailResponseModel]?
    private var showcase: [SRShowcaseResponseModel]?
    private var showcaseModel: SRShowcaseResponseModel?
    private var categoriesModel : SRCategoryResponseModel?
    private var mainDisplayTypeList : [MainPageDisplayTypes]? = []

    private var currentPage: Int = 0
        
    private var total: Int? = nil
    
    func getSliders(showProgress: Bool?,success: (() -> Void)? = nil , error: ((ErrorViewModel) -> Void)? = nil) {
        SRNetworkManagerRequests.getSliders(showProgress: showProgress ?? true).response() {
            (result) in
            switch result {
            case .success(let result):
                self.sliderModel = result.data
                DispatchQueue.main.async {
                    success?()
                }
            case .failure(let err):
                DispatchQueue.main.async {
                    error?(ErrorViewModel(error: err))
                }
            }
        }
    }
    
    func getProducts(showProgress: Bool?, isPagination: Bool = false,success: (() -> Void)? = nil, error: ((ErrorViewModel) -> Void)? = nil) {
        
        if !isPagination {
            products = nil
        }

        if products?.count ?? 0 == 0 {
            currentPage = 1
        } else {
            if (products?.count ?? 0) % SRAppConstants.Query.Values.productsPerPageSize != 0 {
                return
            }
            currentPage = currentPage + 1
        }
        
        var urlQueryItems: [URLQueryItem] = []
        
        urlQueryItems.append(URLQueryItem(name: SRAppConstants.Query.Keys.page, value: String(currentPage)))
        urlQueryItems.append(URLQueryItem(name: SRAppConstants.Query.Keys.perPage, value: String(SRAppConstants.Query.Values.productsPerPageSize)))
        
        SRNetworkManagerRequests.getProducts(showProgress: showProgress ?? true, urlQueryItems: urlQueryItems).response() {
            (result) in
            switch result{
            case .success(let response):
                if self.currentPage != 1 {
                    self.products = self.products! + (response.data ?? [])
                }else{
                    self.products = response.data
                }
                DispatchQueue.main.async {
                    success?()
                }
            case.failure(let err):
                DispatchQueue.main.async {
                    error?(ErrorViewModel(error: err))
                }
            }
        }
        
    }
    
    func getShoppingCartCount(success: (() -> Void)? = nil, error: ((ErrorViewModel) -> Void)? = nil) {
        SRGlobalRequestManager.getShoppingCartCount(success: success, error: error)
    }
    
    func getCategories(showProgress: Bool?,success: (() -> Void)? = nil, error: ((ErrorViewModel) -> Void)? = nil) {
        SRNetworkManagerRequests.getCategories(showProgress: showProgress ?? true).response() {
            (result) in
            switch result{
            case .success(let response):
                self.categoriesWithOptions = response.data
                DispatchQueue.main.async {
                    success?()
                }
            case.failure(let err):
                DispatchQueue.main.async {
                    error?(ErrorViewModel(error: err))
                }
            }
        }
        
    }
    
    
    func getShowCase(showProgress: Bool?,success: (() -> Void)? = nil, error: ((ErrorViewModel) -> Void)? = nil) {
        
        SRNetworkManagerRequests.getShowCase(showProgress: showProgress ?? true).response() {
            (result) in
            switch result{
            case .success(let response):
                self.showcase = response.data
                DispatchQueue.main.async {
                    success?()
                }
            case.failure(let err):
                DispatchQueue.main.async {
                    error?(ErrorViewModel(error: err))
                }
            }
        }
        
    }
    
    func sliderItemCount() -> Int {
        if let sliderModel = sliderModel?.filter({$0.slides?.count ?? 0 > 0}), sliderModel.count > 0 {
            return 1
        }else {
            return 0
        }
    }
    
    func categoryItemCount() -> Int {
        if let categories = categoriesWithOptions?.categories, categories.count > 0 {
            return 1
        } else {
            return 0
        }
    }
    
    func showcaseItemCount() -> Int {
        if let showcase = showcase?.filter({($0.productCount ?? 0 > 0)}) , showcase.count > 0 {
            return showcase.count
        } else {
            return 0
        }
    }
    
    func productItemCount() -> Int {
        return products?.count ?? 0
    }
    
    func getTableSliderVieWModel(position: Int) -> [SliderSlidesModel]? {
        return sliderModel?[position].slides
    }
    
    func getTableProductVieWModel() -> [ProductDetailResponseModel]? {
        return products
    }
    
    func getCategoriesViewModel() -> [SRCategoryResponseModel]? {
        return categoriesWithOptions?.categories
    }
    
    func getCategoryName(position: Int) -> String {
        return categoriesWithOptions?.categories?[position].name ?? ""
    }
    
    func getCategoryId(position: Int) -> String {
        return categoriesWithOptions?.categories?[position].categoryId ?? ""
    }
    
    func getSubCategories(position: Int) -> [SRCategoryResponseModel]? {
        return categoriesWithOptions?.categories?[position].subCategories
    }
    
    func hasSubCategory(position: Int) -> Bool {
        if categoriesWithOptions?.categories?[position].subCategories != nil , !(categoriesWithOptions?.categories?[position].subCategories?.isEmpty ?? false) {
            return true
        }else {
            return false
        }
    }
    
    func getShowCaseViewModel(position: Int) -> SRShowcaseResponseModel? {
        if let showcase = showcase {
            showcaseModel = showcase[position]
        }
        return showcaseModel
    }
    
    func getProductId(position: Int) -> String? {
        return products?[position].id
    }
    
    func getshowCaseProductDetail(position: Int) -> [ProductDetailResponseModel] {
        return showcase?[position].products ?? []
    }
    
    func getHeight(type: CellType) -> Float {
        switch type {
        case .slider:
            if let sliderModel = sliderModel, sliderModel.count > 1 {
                return 250
            } else {
                return 220
            }
        case .categories:
            switch categoriesWithOptions?.mobileSettings?.categoryDisplayType {
            case .imageAndText:
                return 180
            case .imageOnly:
                return 120
            case .textOnly:
                return 120
            case .none:
                return 180
            }
        }
    }
    
    func getEmptyModel() -> EmptyModel {
        EmptyModel(image: .noProductsIcon, title: Constants.emptyViewTitle, description: Constants.emptyViewDescription, button: nil)
    }
    
    func getSectionCount() -> Int {
        var count = 0
        if sliderItemCount() != 0 {
            count += 1
        }
        if productItemCount() != 0 {
            count += 1
        }
        if categoryItemCount() != 0 {
            count += 1
        }
        if showcaseItemCount() != 0 {
            count += 1
        }
        return count
    }
    
    func getSectionAt(position: Int) -> MainPageDisplayTypes {
        if (sliderItemCount() != 0 && (position < 1 && !(mainDisplayTypeList?.contains(where: { $0 == .slider }) ?? false))) { // SLIDER CATEGORIES SHOWCASE PRODUCTS
            mainDisplayTypeList?.append(.slider)
        } else if (categoryItemCount() != 0 && (position < 2 && !(mainDisplayTypeList?.contains(where: { $0 == .categories }) ?? false))) { // CATEGORIES SHOWCASE PRODUCTS
            mainDisplayTypeList?.append(.categories)
        } else if (showcaseItemCount() != 0 && (position < 3 && !(mainDisplayTypeList?.contains(where: { $0 == .showcase }) ?? false))) { // SHOWCASE PRODUCTS
            mainDisplayTypeList?.append(.showcase)
        } else if (productItemCount() != 0 && !(mainDisplayTypeList?.contains(where: { $0 == .products }) ?? false)) { // PRODUCTS
            mainDisplayTypeList?.append(.products)
        }
        return mainDisplayTypeList?[position] ?? .products
    }
    
    func getMobileSettingsEnum() -> CategoryDisplayTypeEnum {
        return categoriesWithOptions?.mobileSettings?.categoryDisplayType ?? .imageAndText
    }
    
    func getCategoriesListViewModel(position: Int) -> CategoriesListViewModel {
        return CategoriesListViewModel(categoryList: getSubCategories(position: position), isSubCategory: true,selectedRowName: getCategoryName(position: position),categoryId: getCategoryId(position: position),categoryDisplayTypeEnum: categoriesWithOptions?.mobileSettings?.categoryDisplayType)
    }
    
    func getProductListViewModel(position: Int) -> ProductListViewModel {
        return ProductListViewModel(categoryId: getCategoryId(position: position),pageTitle: getCategoryName(position: position))
    }
}

enum CellType {
    case slider
    case categories
}

enum MainPageDisplayTypes {
    case slider
    case categories
    case showcase
    case products
}
