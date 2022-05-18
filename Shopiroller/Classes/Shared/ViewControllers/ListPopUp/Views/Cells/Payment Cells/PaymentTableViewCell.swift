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
            paymentTypeText.text = "e_commerce_payment_method_selection_paypal".localized
            paymentTypeImage.image = .paypalIcon
        case .PayAtDoor:
            paymentTypeText.text = "e_commerce_payment_method_selection_pay_at_door".localized
            paymentTypeImage.image = .payAtTheDoorIcon
        case .Online, .Online3DS:
            paymentTypeText.text = "e_commerce_payment_method_selection_credit_card".localized
            paymentTypeImage.image = .creditCartIcon
        case .Transfer:
            paymentTypeText.text = "e_commerce_payment_method_selection_transfer".localized
            paymentTypeImage.image = .bankIcon
        case .none:
            break
        case .Stripe,.Stripe3DS:
            paymentTypeText.text = "e_commerce_payment_method_selection_stripe".localized
            paymentTypeImage.image = .stripeIcon
        case .some(.Other):
            break
        case .some(.Other):
            break
        }
    }
}
