//
//  SRMainPageViewModel.swift
//  shopiroller
//
//  Created by Görkem Gür on 20.09.2021.
//

import UIKit


private struct Constants {
    
    static var title: String { return "empty-view-title".localized }
    
    static var description: String { return "empty-view-description".localized }
    
}

public class SRMainPageViewModel: BaseViewModel {
    
    var sliderModel: [SRSliderDataModel]?
    var categories: [SRCategoryResponseModel]?
    var products: [ProductListModel]?
    var showcase: [SRShowcaseResponseModel]?
    
    var currentPage: Int = 0
    
    func getSliders(success: (() -> Void)? = nil , error: ((ErrorViewModel) -> Void)? = nil) {
        SRNetworkManagerRequests.getSliders().response(using: SRMainPageViewModel.networkManager) {
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
    
    func getProducts(pagination: Bool,succes: (() -> Void)? = nil, error: ((ErrorViewModel) -> Void)? = nil) {
        var urlQueryItems: [URLQueryItem] = []
        
        if products?.count ?? 0 == 0 {
            currentPage = 0
        }else{
            if (products?.count ?? 0) % SRAppConstants.Query.Values.productsPerPageSize != 0 {
                return
            }
            if pagination {
                currentPage = currentPage + 1
            }else {
                currentPage = 0
            }
            
        }
        
        urlQueryItems.append(URLQueryItem(name: SRAppConstants.Query.Keys.page, value: String(SRAppConstants.Query.Values.page)))
        urlQueryItems.append(URLQueryItem(name: SRAppConstants.Query.Keys.perPage, value: String(SRAppConstants.Query.Values.productsPerPageSize)))
        
        SRNetworkManagerRequests.getProducts(urlQueryItems: urlQueryItems).response(using: SRMainPageViewModel.networkManager) {
            (result) in
            switch result{
            case .success(let response):
                DispatchQueue.main.async {
                    if self.currentPage != 0 {
                        self.products = self.products! + (response.data ?? [])
                    }else{
                        self.products = response.data
                    }
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
        SRNetworkManagerRequests.getCategories().response(using: SRMainPageViewModel.networkManager) {
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
        
        SRNetworkManagerRequests.getShowCase().response(using: SRMainPageViewModel.networkManager) {
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
        var count = 0
        if let showcase = showcase {
            showcase.forEach{
                if ($0.products?.count ?? 0 > 0){
                    count = $0.products?.count ?? 0
                }else{
                    count = 0
                }
            }
        }
        return count
    }
    
    func productItemCount() -> Int {
        if let products = products {
            return products.count
        }else{
            return 0
        }
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
    
    func getHeight(type: CellType) -> Float {
        switch type {
        case .slider:
            return 250
        case .categories:
            return 150
        }
    }
    
    func getEmptyModel() -> EmptyModel {
        EmptyModel(image: .paymentFailed, title: Constants.title, description: Constants.description, button: nil)
    }
    
}

enum CellType {
    case slider
    case categories
}
