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
        
        static var freeShipping: String { return "e_commerce_list_free_shipping_badge".localized }
        
        static var soldOut: String { return "e_commerce_list_sold_out_badge".localized }
        
    }
    
    @IBOutlet private weak var productImageContainer: UIView!
    @IBOutlet private weak var productImage: UIImageView!
    @IBOutlet private weak var productTitleLabel: UILabel!
    @IBOutlet private weak var productFooterContainer: UIView!
    @IBOutlet private weak var productDiscountContainer: UIView!
    @IBOutlet private weak var productDiscountLabel: UILabel!
    @IBOutlet private weak var productNewPrice: UILabel!
    @IBOutlet private weak var productOldPrice: UILabel!
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var productPriceContainer: UIView!
    @IBOutlet private weak var freeShippingLabel: PaddingLabel!
    @IBOutlet private weak var soldOutLabel: PaddingLabel!
    @IBOutlet private weak var situationContainer: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        productTitleLabel.textColor = .textSecondary
        productTitleLabel.font = .regular12
        
        productNewPrice.font = .semiBold14
        
        productImageContainer.layer.masksToBounds = true
        
        productDiscountLabel.font = .semiBold12
    }
    
    
    func configureCell(viewModel: ProductViewModel){
        
        productTitleLabel.font = .regular12
        productTitleLabel.textColor = .textSecondary
        productTitleLabel.text = viewModel.getTitle()
        
        if viewModel.hasDiscount() {
            productDiscountContainer.isHidden = false
            productNewPrice.isHidden = false
            
            productDiscountContainer.makeCardView()
            productDiscountContainer.layer.masksToBounds = true
            productDiscountContainer.backgroundColor = .badgeDanger
            productDiscountLabel.text = viewModel.discount
            productDiscountLabel.font = .semiBold12
            
            productOldPrice.textColor = .textPCaption
            productOldPrice.font = .medium12
            productOldPrice.attributedText = ECommerceUtil.getStrikethroughPrice(price: viewModel.getPrice(), currency: viewModel.getCurrency())
            
            productNewPrice.font = .semiBold14
            productNewPrice.text = ECommerceUtil.getFormattedPrice(price: viewModel.getCampaignPrice(), currency: viewModel.getCurrency())
        } else {
            productDiscountContainer.isHidden = true
            productNewPrice.isHidden = true
            productOldPrice.text = ECommerceUtil.getFormattedPrice(price: viewModel.getPrice(), currency: viewModel.getCurrency())
            productOldPrice.font = .semiBold14
            productOldPrice.textColor = .black
        }
        
        if let image = viewModel.getImage() {
            productImage.setImages(url: image)
        } else {
            productImage.image = .emptyProduct
            productImage.contentMode = .scaleAspectFill
        }
        
        if viewModel.isShippingFree() {
            freeShippingLabel.isHidden = false
            freeShippingLabel.setProductSituation(type: .freeShipping)
            freeShippingLabel.textColor = .white
            freeShippingLabel.text = Constants.freeShipping.uppercased()
            freeShippingLabel.font = .bold9
        } else {
            freeShippingLabel.isHidden = true
        }
        
        if viewModel.isOutofStock() {
            soldOutLabel.isHidden = false
            soldOutLabel.setProductSituation(type: .soldOut)
            soldOutLabel.textColor = .textPrimary
            soldOutLabel.text = Constants.soldOut
            soldOutLabel.font = .bold9
        } else if (viewModel.isOutofStock() && viewModel.isUseFixPrice()) {
            soldOutLabel.isHidden = false
        } else {
            soldOutLabel.isHidden = true
        }
        
    }
    
    func startShimmer() {
        stackView.spacing = CGFloat(5)
        [productImageContainer,productDiscountContainer,productTitleLabel,productPriceContainer].forEach {
            Shimmer.start(for: $0)
        }
    }
    
}
