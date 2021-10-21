//
//  OrderDetailViewModel.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 19.10.2021.
//

import Foundation


class OrderDetailViewModel: BaseViewModel {
    
    private let detail: OrderDetailModel?
    
    init(detail: OrderDetailModel?) {
        self.detail = detail
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
        return detail?.paymentType?.title
    }
    
    func isOnlineOrOnline3DS() -> Bool {
        return detail?.paymentType == .Online || detail?.paymentType == .Online3DS
    }
    
    func getPaymentLabels() -> [UILabel] {
        var labelArr: [UILabel] = []
        if((detail?.paymentType == .Online || detail?.paymentType == .Online3DS) && detail?.cardNumber != nil){
            labelArr.append(getLabel(text: detail?.cardNumber))
        }else if(detail?.paymentType == .Transfer){
            if(detail?.paymentAccount != nil){
             
            
                labelArr.append(getLabel(text: detail?.cardNumber))
                labelArr.append(getLabel(text: detail?.cardNumber))
                labelArr.append(getLabel(text: detail?.cardNumber))
                labelArr.append(getLabel(text: detail?.cardNumber))
                
            }else if(detail?.bankAccount != nil){
                labelArr.append(getLabel(text: detail?.bankAccount))
            }
        }
                    
                    
        return labelArr
    }
    
    private func getLabel(text: String?) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .textPCaption
        //TODO: do font
        return label
    }
 
}
