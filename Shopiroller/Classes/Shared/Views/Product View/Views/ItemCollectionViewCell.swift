//
//  ItemCollectionViewCell.swift
//  shopiroller
//
//  Created by Görkem Gür on 29.09.2021.
//

import UIKit
import Kingfisher

class ItemCollectionViewCell: UICollectionViewCell {
    
    private struct Constants {
        
        static var freeShipping: String { return "free-shipping-text".localized }
        
        static var soldOut: String { return "sold-out-text".localized }
        
    }
    
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
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var productPriceContainer: UIView!
    @IBOutlet private weak var freeShippingLabel: UILabel!
    @IBOutlet private weak var soldOutLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    func configureCell(viewModel: ProductViewModel){
        productTitleLabel.text = viewModel.getTitle()
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
            productOldPrice.textColor = .textPCaption
            productOldPrice.attributedText = viewModel.getPrice().makeStrokeCurrency(viewModel.getPrice(), currency: viewModel.getCurrency())
            productNewPrice.text = viewModel.getCampaignPrice() + " " + viewModel.getCurrency()
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
        
        if viewModel.isShippingFree() {
            productImageFreeShippingContainer.isHidden = false
            freeShippingLabel.textColor = .white
            freeShippingLabel.text = Constants.freeShipping
            productImageFreeShippingContainer.layer.backgroundColor  = UIColor.textPrimary.cgColor
            productImageFreeShippingContainer.layer.cornerRadius = 5
            productImageFreeShippingContainer.layer.masksToBounds = true
        }else{
            productImageFreeShippingContainer.isHidden = true
        }
        
        if viewModel.isStockOut() {
            productImageSoldOutContainer.isHidden = false
            soldOutLabel.textColor = .textPrimary
            soldOutLabel.text = Constants.soldOut
            productImageSoldOutContainer.layer.backgroundColor  = UIColor.badgeSecondary.cgColor
            productImageSoldOutContainer.layer.cornerRadius = 5
            productImageSoldOutContainer.layer.masksToBounds = true
        }else{
            productImageSoldOutContainer.isHidden = true
        }

        
        
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
    
    func configureShimmer() {
        stackView.spacing = CGFloat(10)
        [productImageContainer,productDiscountContainer,productTitleLabel,productPriceContainer].forEach {
            Shimmer.start(for: $0)
        }
    }
      
    
}
