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
        return true
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
            if(detail?.paymentAccount != nil) {
                let bankName = [detail?.paymentAccount?.name, " - ", detail?.paymentAccount?.accountName, " / ", detail?.paymentAccount?.accountCode]
                    .compactMap { $0 }
                    .joined(separator: " ")
                labelArr.append(getLabel(text: bankName))
                if let value = detail?.paymentAccount?.nameSurname {
                    labelArr.append(getLabel(attributedText: ECommerceUtil.getBoldNormal("order_details_bank_receiver".localized, value)))
                }
                if let value = detail?.paymentAccount?.accountNumber {
                    labelArr.append(getLabel(attributedText: ECommerceUtil.getBoldNormal("order_details_bank_account".localized, value)))
                }
                if let value = detail?.paymentAccount?.accountAdress {
                    let label = getLabel(attributedText: ECommerceUtil.getBoldNormal("order_details_bank_iban".localized, value))
                    let tap = UITapGestureRecognizer(target: self, action: #selector(OrderDetailViewModel.onClickIbanText))
                    label.isUserInteractionEnabled = true
                    label.addGestureRecognizer(tap)
                    labelArr.append(label)
                }
            }else if(detail?.bankAccount != nil){
                labelArr.append(getLabel(text: detail?.bankAccount))
            }
        }
        return labelArr
    }
    
    private func getLabel(text: String? = nil, attributedText: NSMutableAttributedString? = nil) -> UILabel {
        let label = UILabel()
        label.textColor = .textPCaption
        if attributedText != nil {
            label.attributedText = attributedText
        } else {
            label.text = text
            label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        }
        return label
    }
    
    func getSubTotalText() -> String? {
        return "order_details_bank_subtotal".localized + ECommerceUtil.getFormattedPrice(price: (detail?.totalPrice ?? 0) - (detail?.shippingPrice ?? 0), currency: detail?.currency)
    }
   
    func getShippingTotalText() -> String? {
        return "order_details_bank_shipping".localized + ECommerceUtil.getFormattedPrice(price: detail?.shippingPrice, currency: detail?.currency)
    }
    
    func getTotalText() -> String? {
        return ECommerceUtil.getFormattedPrice(price: detail?.totalPrice, currency: detail?.currency)
    }
    
    func getAddressList() -> [AddressCellModel] {
        var arr: [AddressCellModel] = []
        arr.append(AddressCellModel(type: .delivery, address: String(format: detail?.shippingAdress?.getDescriptionArea() ?? "", detail?.getFullName() ?? ""), image: .deliveryAddress))
        arr.append(AddressCellModel(type: .shipping, address: String(format: detail?.shippingAdress?.getBillingDescriptionArea() ?? "", detail?.getFullName() ?? ""), image: .billingAddress))
        return arr
    }
    
    func getProductList() -> [SROrderProductModel]? {
        return detail?.productList
    }
    
    @objc
    func onClickIbanText(sender:UITapGestureRecognizer) {
        UIPasteboard.general.string = detail?.paymentAccount?.accountAdress
    }
}
