//
//  MyOrderViewModel.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 19.10.2021.
//

import Foundation
import UIKit

open class OrderListViewModel: SRBaseViewModel {
    
    private struct Constants {
        static var emptyOrdersTitle: String { return "empty-orders-title".localized }
        static var emptyOrdersDescription: String { return "empty-orders-description".localized }
        static var emptyOrdersActionButton: String { return "empty-orders-action-button".localized }
    }
    
    private var isOpenedFromResult: Bool? = false
    
    public init(isOpenedFromResult: Bool? = false) {
        self.isOpenedFromResult = isOpenedFromResult
    }
    
    var orderList: [OrderDetailModel]?
    var selectedPosition: Int?
    
    func getOrderList(success: (() -> Void)? = nil , error: ((ErrorViewModel) -> Void)? = nil) {
        let urlQueryItems = [URLQueryItem(name: SRAppConstants.Query.Keys.userId, value: SRAppContext.userId), URLQueryItem(name: "perPage", value: "50"),
                             URLQueryItem(name: "orderBy", value: "OrderByDescending"),]
        
        SRNetworkManagerRequests.getOrderList(urlQueryItems: urlQueryItems).response() {
            (result) in
            switch result {
            case .success(let result):
                self.orderList = result.data
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
    
    func getShoppingCartCount(success: (() -> Void)? = nil, error: ((ErrorViewModel) -> Void)? = nil) {
        SRGlobalRequestManager.getShoppingCartCount(success: success, error: error)
    }
    
    func isOrderListEmpty() -> Bool {
        return orderList?.isEmpty ?? true
    }
    
    func orderListCount() -> Int {
        return orderList?.count ?? 0
    }
    
    func getOrder(position: Int) -> OrderDetailModel? {
        return orderList?[position]
    }
    
    func getOrderId(position: Int) -> String? {
        return orderList?[position].id
    }
    
    func getEmptyModel() -> EmptyModel {
        return EmptyModel(image: .paymentFailed, title: Constants.emptyOrdersTitle, description: Constants.emptyOrdersDescription, button: ButtonModel(title: Constants.emptyOrdersActionButton, color: nil))
    }
    
    func isOpenedFromResultPage() -> Bool? {
        return isOpenedFromResult
    }
    
    func getOrderDetailModel() -> OrderDetailModel? {
        guard let selectedPosition = selectedPosition else {
            return nil
        }
        return orderList?[selectedPosition]
    }
    
}
