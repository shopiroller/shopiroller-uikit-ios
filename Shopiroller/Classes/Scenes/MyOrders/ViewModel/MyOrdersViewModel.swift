//
//  MyOrderViewModel.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 19.10.2021.
//

import Foundation

private struct Constants {
    
    static var emptyOrdersTitle: String { return "empty-orders-title".localized }
    static var emptyOrdersDescription: String { return "empty-orders-description".localized }
    static var emptyOrdersActionButton: String { return "empty-orders-action-button".localized }
}
class MyOrdersViewModel: BaseViewModel {
    
    var orderList: [SROrderModel]?
    
    func getOrderList(success: (() -> Void)? = nil , error: ((ErrorViewModel) -> Void)? = nil) {
        SRNetworkManagerRequests.getOrderList().response(using: SRMainPageViewModel.networkManager) {
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
    
    func isOrderListEmpty() -> Bool {
        return orderList?.isEmpty ?? true
    }
    
    //TODO: CHange image
    func getEmptyModel() -> EmptyModel {
        return EmptyModel(image: .paymentFailed, title: Constants.emptyOrdersTitle, description: Constants.emptyOrdersDescription, button: ButtonModel(title: Constants.emptyOrdersActionButton, color: nil))
    }
    
}
