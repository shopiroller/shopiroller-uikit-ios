//
//  ShoppingCartTableViewCell.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 1.11.2021.
//

import UIKit

protocol ShoppingCartTableViewCellDelegate: ShoppingCartPopUpTableViewCellDelegate {
    func deleteClicked(itemId: String?)
}

class ShoppingCartTableViewCell: UITableViewCell {

    @IBOutlet private weak var warningView: UIView!
    @IBOutlet private weak var warningLabel: UILabel!
    
    @IBOutlet private weak var productImage: UIImageView!
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var deleteButton: UIButton!
    @IBOutlet private weak var discount: UILabel!
    @IBOutlet private weak var price: UILabel!
    
    @IBOutlet private weak var controlView: UIView!
    @IBOutlet private weak var minusButton: UIButton!
    @IBOutlet private weak var count: UILabel!
    @IBOutlet private weak var plusButton: UIButton!
    
    @IBOutlet private weak var productImageToStackView: NSLayoutConstraint!
    
    private var model: ShoppingCartItem?
    private var delegate: ShoppingCartTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        warningView.backgroundColor = .badgeWarningInfo
        warningView.layer.cornerRadius = 6
        warningLabel.textColor = .textSecondary
        
        productImage.layer.cornerRadius = 6
        title.textColor = .textPrimary
        count.textColor = .textPrimary
        discount.textColor = .textPCaption
        price.textColor = .textPrimary
        
        controlView.layer.cornerRadius = 6
    }

    func setup(model: ShoppingCartItem,_ delegate: ShoppingCartTableViewCellDelegate? = nil) {
        self.model = model
        self.delegate = delegate
        
        if let imageUrl = model.product?.featuredImage?.thumbnail {
            productImage.kf.setImage(with: URL(string: imageUrl))
        }
      
        title.text = model.product?.title
        
        if let campaignPrice = model.product?.campaignPrice,
            let productPrice = model.product?.price,
           let quantity = model.quantity {
            
            if(campaignPrice != 0) {
                price.text = ECommerceUtil.getFormattedPrice(price: campaignPrice * Double(quantity), currency: model.product?.currency?.currencySymbol)
                
                let campaignPrice = ECommerceUtil.getFormattedPrice(price: productPrice * Double(quantity), currency: model.product?.currency?.currencySymbol)
                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: campaignPrice)
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
                
                discount.attributedText = attributeString
            } else {
                discount.isHidden = true
                price.text = ECommerceUtil.getFormattedPrice(price: productPrice * Double(quantity), currency: model.product?.currency?.currencySymbol)
            }
        }
        
        count.text = String(model.quantity ?? 0)
        
        if(model.quantity == 1) {
            minusButton.isEnabled = false
        }else {
            minusButton.isEnabled = true
        }
        
        if(model.product?.useFixPrice != true && model.product?.shippingPrice != 0){
            warningView.isHidden = false
            warningLabel.text = String(format: "shopping_cell_cargo_warning".localized, ECommerceUtil.getFormattedPrice(price: model.product?.shippingPrice, currency: model.product?.currency?.rawValue))
            productImageToStackView.constant = 10
        }
        
    }
    
    @IBAction func deleteButtonClicked(_ sender: Any) {
        delegate?.deleteClicked(itemId: model?.id)
    }
    
    @IBAction func minusButtonClicked(_ sender: Any) {
        if let quantity = model?.quantity, quantity != 1 {
            delegate?.updateQuantityClicked(itemId: model?.id, quantity: quantity - 1)
        }
    }
  
    @IBAction func plusButtonClicked(_ sender: Any) {
        if let quantity = model?.quantity {
            if(quantity >= model?.product?.maxQuantityPerOrder ?? 0 || quantity >= model?.product?.stock ?? 0) {
                makeToast(text: String(format: "shopping_cell_maximum_product_message".localized, String(quantity)))
            }else {
                delegate?.updateQuantityClicked(itemId: model?.id, quantity: quantity + 1)
            }
        }
    }
    
    
}
