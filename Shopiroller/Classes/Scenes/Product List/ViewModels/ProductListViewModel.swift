//
//  ProductListViewModel.swift
//  Shopiroller
//
//  Created by Görkem Gür on 25.10.2021.
//

import Foundation
import UIKit


class ProductListViewModel : BaseViewModel {
    
    let categoryId: String?
  
    private var title : String?
    
    private var pageTitle: String?
    
    private var currentPage = 0
    private var productList: [ProductListModel]?
    private var filterModel: FilterModel = FilterModel()
    private var showcaseId: String?
    private var orderOptionType: OrderOptionType?
    private var orderOptionOrientation: OrderOptionOrientation?
    
    private var selectedSortIndex: Int? = 0
    
    init(categoryId: String? = nil , title: String? = nil, pageTitle: String? = nil,showcaseId: String? = nil) {
        self.categoryId = categoryId
        self.title = title
        self.pageTitle = pageTitle
        self.showcaseId = showcaseId
    }
    
    func getProducts(pagination: Bool,succes: (() -> Void)? = nil, error: ((ErrorViewModel) -> Void)? = nil) {
        var urlQueryItems: [URLQueryItem] = []
        
        if !pagination {
            productList = nil
        }
        
        if(hasFilter()) {
            urlQueryItems.append(contentsOf: filterModel.getQueryArray())
        }
        
        if(selectedSortIndex != 0){
            if let orderOptionType = orderOptionType, orderOptionType != .noOption {
                urlQueryItems.append(URLQueryItem(name: SRAppConstants.Query.Keys.sort, value: orderOptionType.title))
            }
            if let orderOptionOrientation = orderOptionOrientation, orderOptionOrientation != .noAssigned {
                urlQueryItems.append(URLQueryItem(name: SRAppConstants.Query.Keys.sort, value: orderOptionOrientation.title))
            }
        }
        
        if productList?.count ?? 0 == 0 {
            currentPage = 0
        } else {
            if ((productList?.count ?? 0) % SRAppConstants.Query.Values.productsPerPageSize != 0) {
                return
            }
                currentPage = currentPage + 1
        }
        
        urlQueryItems.append(URLQueryItem(name: SRAppConstants.Query.Keys.page, value: String(SRAppConstants.Query.Values.page)))
        urlQueryItems.append(URLQueryItem(name: SRAppConstants.Query.Keys.perPage, value: String(SRAppConstants.Query.Values.productsPerPageSize)))
        if let title = title {
            urlQueryItems.append(URLQueryItem(name: SRAppConstants.Query.Keys.title, value: title))
        } else if let categoryId = categoryId {
            urlQueryItems.append(URLQueryItem(name: SRAppConstants.Query.Keys.categoryId, value: categoryId))
        } else if let showcaseId = showcaseId {
            urlQueryItems.append(URLQueryItem(name: SRAppConstants.Query.Keys.showcaseId, value: showcaseId))
        }
        
        SRNetworkManagerRequests.getProductsWithAdvancedFiltered(urlQueryItems: urlQueryItems).response() {
            (result) in
            switch result{
            case .success(let response):
                DispatchQueue.main.async {
                    if self.currentPage != 0 {
                        self.productList = self.productList! + (response.data ?? [])
                    }else{
                        self.productList = response.data
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
    
    func getProductCount() -> Int {
        return productList?.count ?? 0
    }
    
    func getProductModelList() -> [ProductListModel]? {
        return productList
    }
    
    func getShoppingCartCount(succes: (() -> Void)? = nil, error: ((ErrorViewModel) -> Void)? = nil) {
        SRGlobalRequestManager.getShoppingCartCount(success: succes, error: error)
    }
    
    func getEmptyModel() -> EmptyModel {
        EmptyModel(image: .noProductsIcon, title: "empty-view-title".localized, description: "empty-view-description".localized, button: nil)
    }
    
    func getProductId(position: Int) -> String {
        return productList?[position].id ?? ""
    }
    
    func getFilterViewModel() -> FilterViewModel {
        return FilterViewModel(categoryId: categoryId, showcaseId: showcaseId, filterModel: filterModel)
    }
    
    func setFilterModel(_ filterModel: FilterModel) {
        self.filterModel = filterModel
    }
    
    func hasFilter() -> Bool {
        return filterModel.hasFilter()
    }
  
    func getPageTitle() -> String? {
        return pageTitle
    }
    
    func setSelectedSortIndex(index: Int) {
        selectedSortIndex = index
        setOrderOptionType()
    }
    
    func getSelectedSortIndex() -> Int {
        return selectedSortIndex ?? 0
    }
    
    func setOrderOptionType() {
        switch selectedSortIndex {
        case 0:
            orderOptionType = .statsOrderCount
            orderOptionOrientation = .descending
        case 1:
            orderOptionType = .campaignPrice
            orderOptionOrientation = .ascending
        case 2:
            orderOptionType = .campaignPrice
            orderOptionOrientation = .descending
        case 3:
            orderOptionType = .publishmentDate
            orderOptionOrientation = .descending
        case .none:
            break
        default:
            break
    }
}
    
}
