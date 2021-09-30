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
    
    
    func configureProductCell(model: ProductListModel?){
        //        productTitleLabel.textColor = .textSecondary
        //        productTitleLabel.font = .regular12
        //        productOldPrice.font = .medium12
        //        productNewPrice.textColor = .textPrimary
        //        productNewPrice.font = .headTwoSemiBold
        
        
        if model?.stock == 0 {
            productImageFreeShippingContainer.isHidden = true
            productImageSoldOutContainer.isHidden = false
            productImageSoldOutContainer.layer.backgroundColor  = UIColor.badgeSecondary.cgColor
            productImageSoldOutContainer.layer.cornerRadius = 5
            productImageSoldOutContainer.layer.masksToBounds = true
        }
        if Int(model?.shippingPrice ?? 0.0) == 0{
            productImageSoldOutContainer.isHidden = true
            productImageFreeShippingContainer.isHidden = false
            productImageFreeShippingContainer.layer.cornerRadius = 5
            productImageFreeShippingContainer.layer.masksToBounds = true
        }
        
        if model?.campaignPrice != nil, model?.price != nil {
            productDiscountContainer.makeCardView()
            productDiscountContainer.backgroundColor = .dangerBadge
            productDiscountContainer.clipsToBounds = true
            productOldPrice.text = String(format: "%.2f", model?.price as! CVarArg)
            productOldPrice.textColor = .textPCaption
            productNewPrice.text = String(format: "%.2f", model?.campaignPrice as! CVarArg) + " " + (model?.currency)!
            productDiscountLabel.text = "\(calculateDiscount(price: (model?.price)!, campaignPrice: (model?.campaignPrice)!))"
            
        }
        
        productTitleLabel.text = model?.title
        productTitleLabel.textColor = .textSecondary
        productImageContainer.makeCardView()
        productImageContainer.clipsToBounds = true
        if let image = model?.featuredImage?.thumbnail {
            productImage.kf.setImage(with: URL(string: image))
        }else{
            productImage.image = .emptyProduct
        }
        
    }
    
    func configureShowCaseCell(model: String?) {
        productImage.image = .paymentFailed
        productTitleLabel.text = model
    }
    
    
    
    func calculateDiscount(price: Double , campaignPrice: Double) -> String {
        let discount = price - campaignPrice
        let percentage = (discount / price) * 100
        let discountedPercenteage = String(format: "%.0f", percentage)
        return "%\(discountedPercenteage)"
    }
    
}
