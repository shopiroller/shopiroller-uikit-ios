//
//  OrderDetailViewModel.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 19.10.2021.
//

import Foundation


class OrderDetailViewModel: SRBaseViewModel {
    
    private let detail: OrderDetailModel?
    
    private var addressList : [AddressCellModel] = []
    
    init(detail: OrderDetailModel?) {
        self.detail = detail
    }
    
    func getStatusImage() -> UIImage? {
        return detail?.currentStatus?.image
    }
    
    
    func getOrderCode() -> String? {
        return detail?.orderCode
    }
    
    func getCurrentStatus() -> String? {
        return detail?.currentStatus?.text
    }
    
    func getCreatedDate() -> String? {
        return ECommerceUtil.convertServerDate(date: detail?.createdDate, toFormat: ECommerceUtil.ddMMMMyyy + " " + ECommerceUtil.EEEEhhmm)
    }
    
    func isCargoTrackingAvailable() -> Bool {
        return (detail?.shippingTrackingCode != nil || detail?.shippingTrackingCompany != nil) &&
        (detail?.currentStatus == OrderStatusEnum.Shipped || detail?.currentStatus == OrderStatusEnum.Delivered)
    }
    
    func getShippingTrackingCode() -> String? {
        return detail?.shippingTrackingCode
    }
    
    func getShippingTrackingCompany() -> String? {
        return detail?.shippingTrackingCompany
    }
    
    func isPaymentTypeAvailable() -> Bool {
        return detail?.paymentType != nil
    }
    
    func getPaymentMethodTitle() -> String? {
        return detail?.paymentType?.description
    }
   
    func isOnlineOrOnline3DS() -> Bool {
        return detail?.paymentType == .Online || detail?.paymentType == .Online3DS
    }
    
    func getBankName() -> String {
        let bankName = [detail?.paymentAccount?.name, " - ", detail?.paymentAccount?.accountName, " / ", detail?.paymentAccount?.accountCode]
            .compactMap { $0 }
            .joined(separator: " ")
        return bankName
    }
    
    func getBankAccountCode() -> String? {
        return detail?.paymentAccount?.accountCode
    }
    
    func getBankAccountHolderNameSurname() -> String? {
        return detail?.paymentAccount?.nameSurname
    }
    
    func getBankAccountIban() -> String? {
        return detail?.paymentAccount?.accountAddress
    }
    
    func getBankAccountNumber() -> String? {
        return detail?.paymentAccount?.accountNumber
    }
    
    func getCreditCartNumber() -> String? {
       return  "**** **** **** \(detail?.cardNumber?.suffix(4) ?? "")" 
    }
    
    func getPaymentType() -> PaymentTypeEnum? {
        return detail?.paymentType
    }
    
    func getBottomPriceModel() -> BottomPriceModel {
        return BottomPriceModel(subTotalPrice: (detail?.totalPrice ?? 0) - (detail?.shippingPrice ?? 0), shippingPrice: detail?.shippingPrice, totalPrice: detail?.totalPrice, currency: detail?.currency)
    }
    
    func getAddressList() -> [AddressCellModel] {
        addressList.append(AddressCellModel(type: .shipping, address: String(format: detail?.shippingAddress?.getDescriptionArea() ?? "", detail?.getFullName() ?? ""), image: .deliveryAddress))
        addressList.append(AddressCellModel(type: .billing, address: String(format: detail?.billingAddress?.getBillingDescriptionArea() ?? "", detail?.getFullName() ?? ""), image: .billingAddress))
        return addressList
    }
    
    func getProductList() -> [SROrderProductModel]? {
        return detail?.productList
    }
    
    func getShoppingCartCount(success: (() -> Void)? = nil, error: ((ErrorViewModel) -> Void)? = nil) {
        SRGlobalRequestManager.getShoppingCartCount(success: success, error: error)
    }
    
    func getUserNote() -> String {
        if let userNote = detail?.userNote , userNote != "" {
            return userNote
        }
        return ""
    }
}
