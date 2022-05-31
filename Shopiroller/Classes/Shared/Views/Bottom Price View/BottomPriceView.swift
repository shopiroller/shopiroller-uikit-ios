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
    @IBOutlet private weak var taxesInfoLabel: UILabel!
    
    func setup(model: BottomPriceModel) {
        super.setup()
        
        subTotalPriceLabel.textColor = .textSecondary
        subTotalPriceLabel.font = .regular14
        shippingPriceLabel.textColor = .textSecondary
        shippingPriceLabel.font = .regular14
        totalLabel.textColor = .textSecondary
        totalLabel.font = .regular12
        taxesInfoLabel.textColor = .textSecondary
        taxesInfoLabel.font = .regular12
        priceLabel.textColor = .textPrimary
        priceLabel.font = .bold24
        
        taxesInfoLabel.isHidden = model.bottomPriceType == .normal
 
        subTotalPriceLabel.text = "e_commerce_shopping_cart_products_price".localized + ECommerceUtil.getFormattedPrice(price: model.subTotalPrice, currency: model.currency)
        
        let shippingPrice = ECommerceUtil.getFormattedPrice(price: model.shippingPrice, currency: model.currency)
        
        shippingPriceLabel.text = "e_commerce_shopping_cart_shipping_price".localized + shippingPrice
        
        totalLabel.text = "e_commerce_shopping_cart_total_price".localized

        priceLabel.text = ECommerceUtil.getFormattedPrice(price: model.totalPrice, currency: model.currency)
        
        taxesInfoLabel.text = "".localized
    }

}

struct BottomPriceModel {
    let subTotalPrice: Double?
    let shippingPrice: Double?
    let totalPrice: Double?
    let currency: String?
    let bottomPriceType: BottomPriceType?
}

enum BottomPriceType {
    case shoppingCart, normal
}
