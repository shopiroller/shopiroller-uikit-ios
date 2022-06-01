//
//  ShoppingCartTableViewCell.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 1.11.2021.
//

import UIKit

protocol ShoppingCartTableViewCellDelegate: ShoppingCartPopUpTableViewCellDelegate {
    func deleteClicked(itemId: String?,index:Int?)
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
    
    @IBOutlet private weak var divider: UIView!
    
    @IBOutlet private weak var productImageToStackView: NSLayoutConstraint!
    
    private var model: ShoppingCartItem?
    private var delegate: ShoppingCartTableViewCellDelegate?
    private var cellIndexAtRow: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        warningView.backgroundColor = .badgeWarningInfo
        warningView.layer.cornerRadius = 6
        warningLabel.textColor = .textSecondary
        warningLabel.font = .regular12
        
        productImage.layer.cornerRadius = 6
        
        title.textColor = .textPrimary
        title.font = .regular12
        
        count.textColor = .textPrimary
        count.font = .semiBold14
        
        discount.textColor = .textPCaption
        discount.font = .regular12
        
        price.textColor = .textPrimary
        price.font = .semiBold14
        
        controlView.layer.cornerRadius = 6
    }

    func setup(model: ShoppingCartItem,_ delegate: ShoppingCartTableViewCellDelegate? = nil, index: Int?,isLast: Bool) {
        self.model = model
        self.delegate = delegate
        self.cellIndexAtRow = index
        
        divider.isHidden = isLast
        
        if let imageUrl = model.product?.featuredImage?.normal {
            productImage.setImages(url: imageUrl)
        }
      
        title.text = model.product?.title
        
        if let campaignPrice = model.product?.campaignPrice,
           let quantity = model.quantity {
            
            if(campaignPrice != 0) {
                price.text = ECommerceUtil.getFormattedPrice(price: campaignPrice * Double(quantity), currency: model.product?.currency?.currencySymbol)
                
                let campaignPrice = ECommerceUtil.getFormattedPrice(price: (model.product?.price ?? 0) * Double(quantity), currency: model.product?.currency?.currencySymbol)
                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: campaignPrice)
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
                
                discount.attributedText = attributeString
                
            }
        } else if let productPrice = model.product?.price {
            discount.isHidden = true
            price.text = ECommerceUtil.getFormattedPrice(price: productPrice * Double(model.quantity ?? 1), currency: model.product?.currency?.currencySymbol)
        }
        
        count.text = String(model.quantity ?? 0)
        
        if(model.quantity == 1) {
            minusButton.isEnabled = false
        }else {
            minusButton.isEnabled = true
        }
        
        if(model.product?.useFixPrice != true && model.product?.shippingPrice != 0){
            warningView.isHidden = false
            warningLabel.text = String(format: "e_commerce_shopping_cart_cargo_warning".localized, ECommerceUtil.getFormattedPrice(price: model.product?.shippingPrice, currency: model.product?.currency?.rawValue))
            productImageToStackView.constant = 10
        }
    }
    
    @IBAction func deleteButtonClicked(_ sender: Any) {
        delegate?.deleteClicked(itemId: model?.id,index: cellIndexAtRow)
    }
    
    @IBAction func minusButtonClicked(_ sender: Any) {
        if let quantity = model?.quantity, quantity != 1 {
            delegate?.updateQuantityClicked(itemId: model?.id, quantity: quantity - 1)
        }
    }
  
    @IBAction func plusButtonClicked(_ sender: Any) {
        if let quantity = model?.quantity {
            if (model?.product?.variantData?.isEmpty == false) {
                quantity == model?.product?.stock || quantity == model?.product?.maxQuantityPerOrder ? makeToast(text: String(format: "e_commerce_product_detail_maximum_product_message".localized, String(quantity))) : delegate?.updateQuantityClicked(itemId: model?.id, quantity: quantity + 1)
            } else {
                if(quantity >= model?.product?.maxQuantityPerOrder ?? 0 || quantity >= model?.product?.stock ?? 0) {
                    makeToast(text: String(format: "e_commerce_product_detail_maximum_product_message".localized, String(quantity)))
                } else {
                    delegate?.updateQuantityClicked(itemId: model?.id, quantity: quantity + 1)
                }
            }
        }
    }
}

