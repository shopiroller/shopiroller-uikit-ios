//
//  ShoppingCartTableViewCouponCell.swift
//  Shopiroller
//
//  Created by Görkem Gür on 29.07.2022.
//

import UIKit

class ShoppingCartTableViewCouponCell: UITableViewCell {

    @IBOutlet private weak var couponButtonBackgroundView: UIView!
    @IBOutlet private weak var couponButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setup(buttonText: String?) {
        
        self.selectionStyle = .none
        
        couponButton.setTitle(buttonText)
        couponButton.setImage(.couponIcon, for: .normal)
        couponButton.imageView?.tintColor = .black
        couponButtonBackgroundView.layer.cornerRadius = 8
        couponButtonBackgroundView.backgroundColor = .buttonLight
        
        couponButton.tintColor = .black
        couponButton.titleLabel?.font = .regular12
        couponButton.setTitleColor(.textSecondary30)
        
    }
    
}
