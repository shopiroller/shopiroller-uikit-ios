//
//  SRMainPageViewModel.swift
//  shopiroller
//
//  Created by Görkem Gür on 20.09.2021.
//

import UIKit

open class SRMainPageViewModel: SRBaseViewModel {
    
    private struct Constants {
        
        static var emptyViewTitle: String { return "e_commerce_category_product_list_no_empty_view_title".localized }
        
        static var emptyViewDescription: String { return "e_commerce_category_product_list_no_empty_view_description".localized }
        
    }
    
    private var sliderModel: [SRSliderDataModel]?
    private var categoriesWithOptions: SRCategoryResponseWithOptionsModel?
    private var productList: [ProductDetailResponseModel]?
    private var showcaseList: [SRShowcaseResponseModel]?
    private var showcaseModel: SRShowcaseResponseModel?
    private var categoriesModel: SRCategoryResponseModel?
    private var mainDisplayTypeList: [MainPageDisplayTypes] = []
    private var clientModel: ClientResponseModel?

    private var currentPage: Int = 0
    
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
            productList = nil
        }

        if productList?.count ?? 0 == 0 {
            currentPage = 1
        } else {
            if ((productList?.count ?? 0) % SRAppConstants.Query.Values.productsPerPageSize != 0) {
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
                if let productList = response.data , (!productList.isEmpty) {
                    if self.currentPage != 1 {
                        self.productList = self.productList! + productList
                    } else{
                        self.productList = productList
                    }
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
                self.showcaseList = response.data
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
    
    func getClient(success: (() -> Void)? = nil, error: ((ErrorViewModel) -> Void)? = nil) {
        SRNetworkManagerRequests.getClient().response() {
            (result) in
            switch result{
            case .success(let response):
                if let arr = response.data, !arr.isEmpty {
                    self.clientModel = arr[0]
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
    
    func whatsAppMobileIsActive() -> Bool {
        return clientModel?.properties?.whatsAppMobileIsActive ?? false
    }
    
    func getWhatsAppNumber() -> String? {
        return clientModel?.properties?.accountNumber?.replacingOccurrences(of: " ", with: "")
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
        if let showcase = showcaseList?.filter({($0.productCount ?? 0 > 0)}) , showcase.count > 0 {
            return showcase.count
        } else {
            return 0
        }
    }
    
    func productItemCount() -> Int {
        return productList?.count ?? 0
    }
    
    func getTableSliderVieWModel(position: Int) -> [SliderSlidesModel]? {
        return sliderModel?[position].slides
    }
    
    func getTableProductVieWModel() -> [ProductDetailResponseModel]? {
        return productList
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
        if let showcase = showcaseList {
            showcaseModel = showcase[position]
        }
        return showcaseModel
    }
    
    func getProductId(position: Int) -> String? {
        return productList?[position].id
    }
    
    func getshowCaseProductDetail(position: Int) -> [ProductDetailResponseModel] {
        return showcaseList?[position].products ?? []
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
        return mainDisplayTypeList.count
    }
    
    func reloadSections() {
        mainDisplayTypeList.removeAll()
        
        if sliderItemCount() != 0 {
            mainDisplayTypeList.append(.slider)
        }
        
        if categoryItemCount() != 0 {
            mainDisplayTypeList.append(.categories)
        }
        
        if showcaseItemCount() != 0 {
            mainDisplayTypeList.append(.showcase)
        }
        
        if productItemCount() != 0 {
            mainDisplayTypeList.append(.products)
        }
    }
    
    func getSectionAt(position: Int) -> MainPageDisplayTypes {
        return mainDisplayTypeList[position]
    }
    
    func getMobileSettingsEnum() -> CategoryDisplayTypeEnum {
        return categoriesWithOptions?.mobileSettings?.categoryDisplayType ?? .imageAndText
    }
    
    func getCategoriesListViewModel(position: Int) -> SRCategoriesListViewModel {
        return SRCategoriesListViewModel(categoryList: getSubCategories(position: position), isSubCategory: true,selectedRowName: getCategoryName(position: position),categoryId: getCategoryId(position: position),categoryDisplayTypeEnum: categoriesWithOptions?.mobileSettings?.categoryDisplayType)
    }
    
    func getProductListViewModel(position: Int) -> SRProductListViewModel {
        return SRProductListViewModel(categoryId: getCategoryId(position: position),pageTitle: getCategoryName(position: position))
    }
    
    func getSliderCategoryName(id: String?) -> String? {
        var categoryName : String? = ""
        if let categories = categoriesWithOptions?.categories {
            for category in categories {
                if (category.categoryId == id) {
                    categoryName = category.name
                }
            }
        }
        return categoryName
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
