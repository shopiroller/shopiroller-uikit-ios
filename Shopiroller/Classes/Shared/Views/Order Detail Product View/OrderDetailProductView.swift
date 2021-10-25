//
//  OrderDetailProductView.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 22.10.2021.
//

import UIKit

extension OrderDetailProductView : NibLoadable { }

class OrderDetailProductView: BaseView {
    
    @IBOutlet weak var orderImage: UIImageView!
    @IBOutlet weak var orderTitle: UILabel!
    @IBOutlet weak var orderPiece: UILabel!
    @IBOutlet weak var orderPrice: UILabel!
    
    func setup(model: SROrderProductModel) {
        super.setup()
        setupFromNib()
        
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
        
        orderPrice.text = ECommerceUtil.getFormattedPrice(price:(calculatedPrice ?? 0 * Double(model.quantity ?? 0)), currency: ECommerceUtil.getCurrencySymbol(currency: model.currency))
    }
    
}
