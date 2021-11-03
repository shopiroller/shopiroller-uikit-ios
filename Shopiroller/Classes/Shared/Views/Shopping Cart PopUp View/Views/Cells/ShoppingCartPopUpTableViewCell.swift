//
//  ShoppingCartPopUpTableViewCell.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 3.11.2021.
//

import UIKit

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
    private var indexPathRow: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(model: ShoppingCartItem, indexPathRow: Int) {
        self.model = model
        self.indexPathRow = indexPathRow
        
        if let imageUrl = model.product?.featuredImage?.thumbnail {
            productImage.kf.setImage(with: URL(string: imageUrl))
        }
        
        titleLabel.text = model.product?.title
        
        minusButton.isEnabled = model.quantity != 1
        
       // shoppingCartItem.quantity < shoppingCartItem.product.maxQuantityPerOrder && shoppingCartItem.quantity < shoppingCartItem.product.stock
        
        
    }
    
    @IBAction func minusButtonClicked(_ sender: Any) {
    }
    
    @IBAction func plusButtonClicked(_ sender: Any) {
    }
    
}
