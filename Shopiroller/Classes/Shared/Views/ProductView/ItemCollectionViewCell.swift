//
//  ItemCollectionViewCell.swift
//  shopiroller
//
//  Created by Görkem Gür on 29.09.2021.
//

import UIKit
import Kingfisher

class ItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var productImageContainer: UIView!
    @IBOutlet private weak var productImage: UIImageView!
    @IBOutlet private weak var productTitleLabel: UILabel!
    @IBOutlet private weak var productFooterContainer: UIView!
    @IBOutlet private weak var productDiscountContainer: UIView!
    @IBOutlet private weak var productDiscountLabel: UILabel!
    @IBOutlet private weak var productNewPrice: UILabel!
    @IBOutlet private weak var productImageSoldOutContainer: UIView!
    @IBOutlet private weak var productImageFreeShippingContainer: UIView!
    @IBOutlet private weak var productOldPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    func configureCell(viewModel: ProductViewModel){
        productTitleLabel.text = "viewModel.getTitle()viewModel.getTitle()viewModel.getTitle()viewModel.getTitle()viewModel.getTitle()viewModel.getTitle()"
        productTitleLabel.textColor = .textSecondary
        productImageContainer.makeCardView()
        productImageContainer.clipsToBounds = true
        
        if viewModel.hasDiscount() {
            productDiscountContainer.isHidden = false
            productNewPrice.isHidden = false
            productDiscountContainer.makeCardView()
            productDiscountContainer.layer.masksToBounds = true
            productDiscountContainer.backgroundColor = .badgeSecondary
            productDiscountLabel.text = viewModel.discount
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: viewModel.getPrice())
            attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            productOldPrice.textColor = .textPCaption
            productOldPrice.attributedText = attributeString
            productNewPrice.text = viewModel.getCampaignPrice()
        }else{
            productDiscountContainer.isHidden = true
            productNewPrice.isHidden = true
            productOldPrice.text = viewModel.getPrice()
            productOldPrice.textColor = .black
            productOldPrice.font.withSize(17)

        }
        
        if let image = viewModel.getImage() {
            productImage.kf.setImage(with: URL(string: image))
        }else{
            productImage.image = .emptyProduct
        }
        
        self.productImageFreeShippingContainer.isHidden = !viewModel.isShippingFree()
        
        
        
        //        productTitleLabel.textColor = .textSecondary
        //        productTitleLabel.font = .regular12
        //        productOldPrice.font = .medium12
        //        productNewPrice.textColor = .textPrimary
        //        productNewPrice.font = .headTwoSemiBold
        
//
//        if model?.stock == 0 {
//            productImageFreeShippingContainer.isHidden = true
//            productImageSoldOutContainer.isHidden = false
//            productImageSoldOutContainer.layer.backgroundColor  = UIColor.badgeSecondary.cgColor
//            productImageSoldOutContainer.layer.cornerRadius = 5
//            productImageSoldOutContainer.layer.masksToBounds = true
//        }
        
        
//        if let image = model?.featuredImage?.thumbnail {
//            productImage.kf.setImage(with: URL(string: image))
//        }else{
//            productImage.image = .emptyProduct
//        }
        
    }
    
}
