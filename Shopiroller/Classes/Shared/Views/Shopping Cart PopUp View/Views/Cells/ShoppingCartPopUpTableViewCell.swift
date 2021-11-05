//
//  ShoppingCartPopUpTableViewCell.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 3.11.2021.
//

import UIKit

protocol ShoppingCartPopUpTableViewCellDelegate {
    func updateQuantityClicked(itemId: String?, quantity: Int)
}

class ShoppingCartPopUpTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stockView: UIView!
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var controlView: UIView!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    
    private var model: ShoppingCartItem?
    private var delegate: ShoppingCartPopUpTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        productImage.layer.cornerRadius = 6
        titleLabel.textColor = .textPrimary
        stockView.layer.cornerRadius = 6
        stockView.backgroundColor = .coral15
        stockLabel.textColor = .orangeyRed
        
        controlView.layer.cornerRadius = 6
    }

    func setup(model: ShoppingCartItem, delegate: ShoppingCartPopUpTableViewCellDelegate) {
        self.model = model
        self.delegate = delegate
        
        if let imageUrl = model.product?.featuredImage?.thumbnail {
            productImage.kf.setImage(with: URL(string: imageUrl))
        }
        
        titleLabel.text = model.product?.title
        
        minusButton.isEnabled = model.quantity != 1
      
        if let quantity = model.quantity,
            let maxQuantityPerOrder = model.product?.maxQuantityPerOrder,
           let stock = model.product?.stock {
            
            plusButton.isEnabled = quantity < maxQuantityPerOrder && quantity < stock
        }
    
        if let messages = model.messages, !messages.isEmpty, let key = messages[0].key, key != .UpdatedProduct {
            stockView.isHidden = false
            if let stock = model.product?.stock, key == .NotEnoughStock {
                stockLabel.text = String(format: key.text, String(stock))
                countLabel.text = String(stock)
                controlView.isHidden = false
            }else {
                stockLabel.text = key.text
                controlView.isHidden = true
            }
        }else {
            stockView.isHidden = true
        }
        
    }
    
    @IBAction func minusButtonClicked(_ sender: Any) {
        if let quantity = model?.quantity, quantity != 1 {
            delegate?.updateQuantityClicked(itemId: model?.id, quantity: quantity - 1)
        }
    }
    
    @IBAction func plusButtonClicked(_ sender: Any) {
        if let quantity = model?.quantity {
            if(quantity >= model?.product?.maxQuantityPerOrder ?? 0 || quantity >= model?.product?.stock ?? 0) {
                makeToast(String(format: "shopping_cell_maximum_product_message".localized, String(quantity)))
            }else {
                delegate?.updateQuantityClicked(itemId: model?.id, quantity: quantity + 1)
            }
        }
    }
    
}
