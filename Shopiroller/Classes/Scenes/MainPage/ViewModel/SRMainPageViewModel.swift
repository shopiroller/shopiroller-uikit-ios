//
//  SRMainPageViewModel.swift
//  shopiroller
//
//  Created by Görkem Gür on 20.09.2021.
//

import UIKit

public class SRMainPageViewModel: BaseViewModel {
    
    private struct Constants {
        
        static var emptyViewTitle: String { return "empty-view-title".localized }
        
        static var emptyViewDescription: String { return "empty-view-description".localized }
        
    }
    
    private var sliderModel: [SRSliderDataModel]?
    private var categories: [SRCategoryResponseModel]?
    private var products: [ProductListModel]?
    private var showcase: [SRShowcaseResponseModel]?
    private var showcaseModel: SRShowcaseResponseModel?
    private var categoriesModel : SRCategoryResponseModel?
    
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
                self.categories = response.data
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
        if let sliderModel = sliderModel, sliderModel.count > 0 {
            return 1
        }else {
            return 0
        }
    }
    
    func categoryItemCount() -> Int {
        if let categories = categories, categories.count > 0 {
            return 1
        } else {
            return 0
        }
    }
    
    func showcaseItemCount() -> Int {
        return showcaseModel?.showcase?.productCount ?? 0
    }
    
    func productItemCount() -> Int {
        products?.count ?? 0
    }
    
    func getTableSliderVieWModel(position: Int) -> [SliderSlidesModel]? {
        return sliderModel?[position].slides
    }
    
    func getTableProductVieWModel() -> [ProductListModel]? {
        return products
    }
    
    func getCategoriesViewModel() -> [SRCategoryResponseModel]? {
        return categories
    }
    
    func getCategoryName(position: Int) -> String {
        return categories?[position].name ?? ""
    }
    
    func getCategoryId(position: Int) -> String {
        return categories?[position].categoryId ?? ""
    }
    
    func getSubCategories(position: Int) -> [SRCategoryResponseModel]? {
        return categories?[position].subCategories
    }
    
    func hasSubCategory(position: Int) -> Bool {
        if categories?[position].subCategories != nil , !(categories?[position].subCategories?.isEmpty ?? false) {
            return true
        }else {
            return false
        }
    }
    
    func getShowCaseViewModel(position: Int) -> SRShowcaseResponseModel? {
        showcaseModel = showcase?[position]
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
            return 150
        }
    }
    
    func getEmptyModel() -> EmptyModel {
        EmptyModel(image: .noProductsIcon, title: Constants.emptyViewTitle, description: Constants.emptyViewDescription, button: nil)
    }
}

enum CellType {
    case slider
    case categories
}
