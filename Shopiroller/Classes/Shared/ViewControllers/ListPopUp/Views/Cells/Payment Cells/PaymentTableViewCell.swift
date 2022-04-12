//
//  PaymentTableViewCell.swift
//  Shopiroller
//
//  Created by Görkem Gür on 9.11.2021.
//

import UIKit

class PaymentTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var paymentTypeImage: UIImageView!
    @IBOutlet private weak var paymentTypeText: UILabel!
    
    private var index: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        paymentTypeText.textColor = .textPrimary
        paymentTypeText.font = .semiBold13
        
    }
    
    func setupCell(model: SupportedPaymentType?,index: Int) {
        self.index = index
        switch model?.paymentType {
        case .PayPal:
            paymentTypeText.text = "list-pop-up-paypal-text".localized
            paymentTypeImage.image = .paypalIcon
        case .PayAtDoor:
            paymentTypeText.text = "list-pop-up-pay-at-the-door-text".localized
            paymentTypeImage.image = .payAtTheDoorIcon
        case .Online, .Online3DS:
            paymentTypeText.text = "list-pop-up-credit-cart-text".localized
            paymentTypeImage.image = .creditCartIcon
        case .Transfer:
            paymentTypeText.text = "list-pop-up-bank-transfer-text".localized
            paymentTypeImage.image = .bankIcon
        case .none:
            break
        case .Stripe,.Stripe3DS:
            paymentTypeText.text = "list-pop-up-stripe-text".localized
            paymentTypeImage.image = .stripeIcon
        case .some(.Other):
            break
        case .some(.Other):
            break
        }
    }
}
