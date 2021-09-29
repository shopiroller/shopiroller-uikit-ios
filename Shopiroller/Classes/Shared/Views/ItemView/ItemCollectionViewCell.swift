//
//  ItemCollectionViewCell.swift
//  shopiroller
//
//  Created by Görkem Gür on 29.09.2021.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var productImageContainer: UIView!
    @IBOutlet private weak var productImage: UIImageView!
    @IBOutlet private weak var productImageSituation: UILabel!
    @IBOutlet private weak var productTitleLabel: UILabel!
    @IBOutlet private weak var productFooterContainer: UIView!
    @IBOutlet private weak var productDiscountContainer: UIView!
    @IBOutlet private weak var productDiscountLabel: UILabel!
    @IBOutlet private weak var productNewPrice: UILabel!
    @IBOutlet private weak var productOldPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func configureProductCell(model: ProductListModel?){
        
        productTitleLabel.text = model?.title
    }

}
