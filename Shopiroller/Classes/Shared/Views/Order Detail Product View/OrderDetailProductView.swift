//
//  OrderDetailProductView.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 22.10.2021.
//

import UIKit


class OrderDetailProductView: SRBaseView {
    
    @IBOutlet private weak var orderImage: UIImageView!
    @IBOutlet private weak var orderTitle: UILabel!
    @IBOutlet private weak var orderPiece: UILabel!
    @IBOutlet private weak var orderPrice: UILabel!
    @IBOutlet private weak var divider: UIView!
    
    func configure(model: SROrderProductModel,isLast: Bool) {
        
        if let url = model.featuredImage?.thumbnail {
            orderImage.kf.setImage(with: URL(string: url))
        }
        
        divider.isHidden = isLast
        
        orderTitle.textColor = .textPCaption
        orderTitle.text = model.title
        
        if let quantity = model.quantity {
            orderPiece.textColor = .textPCaption
            orderPiece.attributedText = ECommerceUtil.getBoldNormal("e_commerce_order_details_quantity".localized, String(quantity))
        }
        
        orderPrice.text = ECommerceUtil.getFormattedPrice(price: ((model.price ?? 0.0) * Double(model.quantity ?? 0)), currency: model.currency)
        
    }
    
}
