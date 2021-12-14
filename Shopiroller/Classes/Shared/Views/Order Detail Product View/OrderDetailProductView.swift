//
//  OrderDetailProductView.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 22.10.2021.
//

import UIKit


class OrderDetailProductView: BaseView {
    
    @IBOutlet private weak var orderImage: UIImageView!
    @IBOutlet private weak var orderTitle: UILabel!
    @IBOutlet private weak var orderPiece: UILabel!
    @IBOutlet private weak var orderPrice: UILabel!
    
    func setup(model: SROrderProductModel) {
        super.setup()
        
        if let url = model.featuredImage?.thumbnail {
            orderImage.kf.setImage(with: URL(string: url))
        }
        
        orderTitle.textColor = .textPCaption
        orderTitle.text = model.title
        
        if let quantity = model.quantity {
            orderPiece.textColor = .textPCaption
            orderPiece.attributedText = ECommerceUtil.getBoldNormal("order_details_quantity".localized, String(quantity))
        }
        
        let calculatedPrice: Double? = (model.campaignPrice == 0) ? model.paidPrice : model.campaignPrice
        
        orderPrice.text = ECommerceUtil.getFormattedPrice(price:(calculatedPrice ?? 0 * Double(model.quantity ?? 0)), currency: model.currency?.currencySymbol)
    }
    
}
