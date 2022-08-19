//
//  ShoppingCartTableViewCouponCell.swift
//  Shopiroller
//
//  Created by Görkem Gür on 29.07.2022.
//

import UIKit

protocol ShoppingCartTableViewCouponCellDelegate {
    func removeButtonTapped()
    func couponButtonTapped()
}

class ShoppingCartTableViewCouponCell: UITableViewCell {

    @IBOutlet private weak var couponButtonBackgroundView: UIView!
    @IBOutlet private weak var couponButton: UIButton!
    @IBOutlet private weak var couponRemoveButton: UIButton!
    
    private var delegate : ShoppingCartTableViewCouponCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        
        couponButton.setImage(.couponIcon, for: .normal)
        couponButton.imageView?.tintColor = .black
        couponButtonBackgroundView.layer.cornerRadius = 8
        couponButtonBackgroundView.backgroundColor = .buttonLight
        
        couponButton.tintColor = .black
        couponButton.titleLabel?.font = .regular14
        couponButton.setTitleColor(.textSecondary30)
        
        couponRemoveButton.setTitleColor(.red)
        couponRemoveButton.titleLabel?.font = .regular8
        couponRemoveButton.setTitle("e_commerce_shopping_cart_coupon_remove_discount".localized)
    }

    func setup(buttonText: String?, delegate: ShoppingCartTableViewCouponCellDelegate) {
        couponRemoveButton.isHidden = buttonText != "e_commerce_shopping_cart_coupon_dialog_textfield_placeholder".localized ? false : true
        self.delegate = delegate
        couponButton.setTitle(buttonText)
    }
    
    @IBAction private func couponButtonTapped() {
        delegate?.couponButtonTapped()
    }
    
    @IBAction private func removeButtonTapped() {
        delegate?.removeButtonTapped()
    }
    
}
