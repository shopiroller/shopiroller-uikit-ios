//
//  ProductListViewModel.swift
//  Shopiroller
//
//  Created by Görkem Gür on 25.10.2021.
//

import Foundation
import UIKit


class ProductListViewModel : BaseViewModel {
    
    private struct Constants {
        
        static var emptyViewTitle: String { return "empty-view-title".localized }
        
        static var emptyViewDescription: String { return "empty-view-description".localized }
        
    }
    
    var categoryId: String?
    
    private var currentPage = 0
    
    private var productList: [ProductListModel]?

    
    init(categoryId: String? = String()) {
        self.categoryId = categoryId
    }
    
    func getProducts(pagination: Bool,succes: (() -> Void)? = nil, error: ((ErrorViewModel) -> Void)? = nil) {
        var urlQueryItems: [URLQueryItem] = []
        
        if productList?.count ?? 0 == 0 {
            currentPage = 0
        }else{
            if (productList?.count ?? 0) % SRAppConstants.Query.Values.productsPerPageSize != 0 {
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
        urlQueryItems.append(URLQueryItem(name: SRAppConstants.Query.Keys.categoryId, value: self.categoryId))
        
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
    
    func getProductModel() -> [ProductListModel]? {
        return productList
    }
    
    func getShoppingCartCount(succes: (() -> Void)? = nil, error: ((ErrorViewModel) -> Void)? = nil) {
        SRGlobalRequestManager.getShoppingCartCount(success: succes, error: error)
    }
    
    func getEmptyModel() -> EmptyModel {
        EmptyModel(image: .cargoShippingImage, title: Constants.emptyViewTitle, description: Constants.emptyViewDescription, button: nil)
    }
    
    func getProductId(position: Int) -> String {
        return productList?[position].id ?? ""
    }
}
