//
//  BottomPriceView.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 1.11.2021.
//

import UIKit


class BottomPriceView: BaseView {

    @IBOutlet weak var subTotal: UILabel!
    @IBOutlet weak var shipping: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var price: UILabel!
    
    func setup(model: BottomPriceModel) {
        super.setup()
        setupFromNib()
        
        subTotal.textColor = .textSecondary
        shipping.textColor = .textSecondary
        total.textColor = .textSecondary
        price.textColor = .textPrimary
 
        subTotal.text = "bottom_price_view_subtotal".localized + ECommerceUtil.getFormattedPrice(price: model.subTotalPrice, currency: model.currency)
        
        let shippingPrice = (model.shippingPrice == 0.0) ? "bottom_price_view_free".localized  : ECommerceUtil.getFormattedPrice(price: model.shippingPrice, currency: model.currency)
        
        shipping.text = "bottom_price_view_shipping".localized + shippingPrice
        
        total.text = "bottom_price_view_total".localized

        price.text = ECommerceUtil.getFormattedPrice(price: model.totalPrice, currency: model.currency)
    }

}

struct BottomPriceModel {
    let subTotalPrice: Double?
    let shippingPrice: Double?
    let totalPrice: Double?
    let currency: String?
}
