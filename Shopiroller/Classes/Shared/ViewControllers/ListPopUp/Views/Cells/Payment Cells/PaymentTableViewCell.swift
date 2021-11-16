//
//  PaymentTableViewCell.swift
//  Shopiroller
//
//  Created by Görkem Gür on 9.11.2021.
//

import UIKit

protocol PaymentTableViewCellDelegate {
    func getPaymentIndex(index: Int?)
}

class PaymentTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var paymentTypeImage: UIImageView!
    @IBOutlet private weak var paymentTypeText: UILabel!
    
    var delegate: PaymentTableViewCellDelegate?
    
    private var index: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        paymentTypeText.textColor = .textPrimary
        paymentTypeText.font = UIFont.boldSystemFont(ofSize: 14)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        self.addGestureRecognizer(tapGesture)
        tapGesture.delegate = self
        
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
        case .Online:
            paymentTypeText.text = "list-pop-up-credit-cart-text".localized
            paymentTypeImage.image = .creditCartIcon
        case .Online3DS:
            paymentTypeText.text = "list-pop-up-credit-cart-text".localized
            paymentTypeImage.image = .creditCartIcon
        case .Transfer:
            paymentTypeText.text = "list-pop-up-bank-transfer-text".localized
            paymentTypeImage.image = .bankIcon
        case .none:
            break
        }
    }
    
    @objc func cellTapped() {
        delegate?.getPaymentIndex(index: self.index)
    }
}
