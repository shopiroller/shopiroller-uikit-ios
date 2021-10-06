//
//  SRMainPageViewModel.swift
//  shopiroller
//
//  Created by Görkem Gür on 20.09.2021.
//

import UIKit


public class SRMainPageViewModel {
    
    var sliderModel: [SRSliderDataModel]?
    var categories: [SRCategoryResponseModel]?
    var products: [ProductListModel]?
    var showcase: [SRShowcaseResponseModel]?
    
    private let networkManager: SRNetworkManager
    
    private var currentPage: Int = 0
    
    
    public init (networkManager: SRNetworkManager = SRNetworkManager()) {
        self.networkManager = networkManager
    }
    
    func getSliders(success: (() -> Void)? = nil , error: ((ErrorViewModel) -> Void)? = nil) {
        SRNetworkManagerRequests.getSliders().response(using: networkManager) {
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
    
    func getProducts(succes: (() -> Void)? = nil, error: ((ErrorViewModel) -> Void)? = nil) {
        var urlQueryItems: [URLQueryItem] = []
        
        if products?.count ?? 0 == 0 {
            currentPage = 0
        }else{
            if (products?.count ?? 0) % SRAppConstants.Query.Values.productsPerPageSize != 0 {
                return
            }
            currentPage = currentPage + 1
        }
        
        urlQueryItems.append(URLQueryItem(name: SRAppConstants.Query.Keys.page, value: String(SRAppConstants.Query.Values.page)))
        urlQueryItems.append(URLQueryItem(name: SRAppConstants.Query.Keys.perPage, value: String(SRAppConstants.Query.Values.productsPerPageSize)))
        
        SRNetworkManagerRequests.getProducts(urlQueryItems: urlQueryItems).response(using: networkManager) {
            (result) in
            switch result{
            case .success(let response):
                if self.currentPage != 0 {
                    self.products = self.products! + (response.data ?? [])
                }else{
                    self.products = response.data
                }
                DispatchQueue.main.async {
                    succes?()
                    print("------------------")
                    print("------------------")
                    print("------------------")
                    print(self.currentPage)
                    print("------------------")
                    print("------------------")
                    print("------------------")
                }
            case.failure(let err):
                DispatchQueue.main.async {
                    error?(ErrorViewModel(error: err))
                }
            }
        }
        
    }
    
    func getCategories(succes: (() -> Void)? = nil, error: ((ErrorViewModel) -> Void)? = nil) {
        SRNetworkManagerRequests.getCategories().response(using: networkManager) {
            (result) in
            switch result{
            case .success(let response):
                self.categories = response.data
                DispatchQueue.main.async {
                    succes?()
                }
            case.failure(let err):
                DispatchQueue.main.async {
                    error?(ErrorViewModel(error: err))
                }
            }
        }
        
    }
    
    
    func getShowCase(succes: (() -> Void)? = nil, error: ((ErrorViewModel) -> Void)? = nil) {
        
        SRNetworkManagerRequests.getShowCase().response(using: networkManager) {
            (result) in
            switch result{
            case .success(let response):
                self.showcase = response.data
                DispatchQueue.main.async {
                    succes?()
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
        if let showcase = showcase , showcase.count > 0 {
            return 2
        }else{
            return 0
        }
    }
    
    func productItemCount() -> Int {
        return products?.count ?? 0
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
    
    func getShowCaseViewModel(position: Int) -> SRShowcaseResponseModel? {
        return showcase?[position]
    }
    
    
    func getSection(section: Int) -> CellType {
        switch section{
        case 0:
            return .slider
        case 1:
            return .categories
        case 2:
            return .showCase
        case 3:
            return .products
        default:
            return .products
        }
    }
    
    func getHeight(type: CellType) -> Float {
        switch type {
        case .slider:
            return 250
        case .categories:
            return 150
        case .showCase:
            return 200
        case .products:
            return 250
        }
    }
    
    
    
}

enum CellType {
    case slider
    case categories
    case showCase
    case products
}
