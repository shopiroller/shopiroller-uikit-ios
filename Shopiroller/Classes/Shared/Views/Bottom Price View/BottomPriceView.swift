//
//  BottomPriceView.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 1.11.2021.
//

import UIKit


class BottomPriceView: SRBaseView {

    @IBOutlet private weak var subTotalPriceLabel: UILabel!
    @IBOutlet private weak var shippingPriceLabel: UILabel!
    @IBOutlet private weak var totalLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    
    func setup(model: BottomPriceModel) {
        super.setup()
        
        subTotalPriceLabel.textColor = .textSecondary
        subTotalPriceLabel.font = .regular14
        shippingPriceLabel.textColor = .textSecondary
        shippingPriceLabel.font = .regular14
        totalLabel.textColor = .textSecondary
        totalLabel.font = .regular12
        priceLabel.textColor = .textPrimary
        priceLabel.font = .bold24
 
        subTotalPriceLabel.text = "bottom_price_view_subtotal".localized + ECommerceUtil.getFormattedPrice(price: model.subTotalPrice, currency: model.currency)
        
        let shippingPrice = ECommerceUtil.getFormattedPrice(price: model.shippingPrice, currency: model.currency)
        
        shippingPriceLabel.text = "bottom_price_view_shipping".localized + shippingPrice
        
        totalLabel.text = "bottom_price_view_total".localized

        priceLabel.text = ECommerceUtil.getFormattedPrice(price: model.totalPrice, currency: model.currency)
    }

}

struct BottomPriceModel {
    let subTotalPrice: Double?
    let shippingPrice: Double?
    let totalPrice: Double?
    let currency: String?
}
