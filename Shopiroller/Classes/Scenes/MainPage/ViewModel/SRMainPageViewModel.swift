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
        
        urlQueryItems.append(URLQueryItem(name: "page", value: String(1)))
        urlQueryItems.append(URLQueryItem(name: "perPage", value: String(50)))
        
        
        SRNetworkManagerRequests.getProducts(urlQueryItems: urlQueryItems).response(using: networkManager) {
            (result) in
            switch result{
            case .success(let response):
                self.products = response.data
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
        return 0
    }
    
    func productItemCount() -> Int {
        return products?.count ?? 0
    }
    
    
    func getTableSliderVieWModel(position: Int) -> [SliderSlidesModel]? {
        return sliderModel?[position].slides
    }
    
    func getTableProductVieWModel(position: Int) -> ProductListModel? {
        return products?[position]
    }
    
    func getCategoriesViewModel() -> [SRCategoryResponseModel]? {
        return categories
    }
    
    func getShowCaseViewModel() -> [SRShowcaseResponseModel]? {
        return showcase
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
            return 100
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
