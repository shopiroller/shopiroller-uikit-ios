//
//  CheckOutProgress.swift
//  Shopiroller
//
//  Created by Görkem Gür on 1.11.2021.
//

import Foundation


class CheckOutProgress : SRBaseView {

    private struct Constants {
        static var adressText: String { return "e_commerce_checkout_top_layout_address_text".localized }
        static var paymentText: String { return "e_commerce_checkout_top_layout_payment_text".localized }
        static var infoText: String { return "e_commerce_checkout_top_layout_info_text".localized }
        
    }
    
    @IBOutlet private weak var addressDotImage: UIImageView!
    @IBOutlet private weak var addressToPaymentLine: UIView!
    @IBOutlet private weak var paymentDotImage: UIImageView!
    @IBOutlet private weak var paymentToInfoLine: UIView!
    @IBOutlet private weak var infoDotImage: UIImageView!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var paymentLabel: UILabel!
    @IBOutlet private weak var infoLabel: UILabel!

    override func setup() {
        super.setup()
        
        addressLabel.text = Constants.adressText
        addressLabel.font = .semiBold12
        addressLabel.textColor = .textPrimary
        addressToPaymentLine.backgroundColor = UIColor.textPrimary.withAlphaComponent(0.1)
        
        addressDotImage.backgroundColor = .black
        addressDotImage.layer.cornerRadius = addressDotImage.frame.width / 2
        
        paymentLabel.text = Constants.paymentText
        paymentLabel.font = .semiBold12
        paymentLabel.textColor = .textPCaption
        paymentToInfoLine.backgroundColor = UIColor.textPrimary.withAlphaComponent(0.1)
        
        paymentDotImage.backgroundColor = .veryLightPink
        paymentDotImage.layer.cornerRadius = paymentDotImage.frame.width / 2
        
        infoLabel.textColor = .textPCaption
        infoLabel.font = .semiBold12
        infoLabel.text = Constants.infoText
        
        infoDotImage.backgroundColor = .veryLightPink
        infoDotImage.layer.cornerRadius = infoDotImage.frame.width / 2
        
    }
    
    func configureView(stage: ProgressStageEnum) {
        switch stage {
        case .payment:
            paymentLabel.textColor = .textPrimary
            paymentDotImage.backgroundColor = .black
            paymentToInfoLine.backgroundColor = UIColor.textPrimary.withAlphaComponent(0.1)
            addressToPaymentLine.backgroundColor = .black
            infoDotImage.backgroundColor = .veryLightPink
            infoDotImage.layer.cornerRadius = infoDotImage.frame.width / 2
            infoLabel.textColor = .textPCaption
            infoLabel.text = Constants.infoText
        case .info:
            paymentLabel.textColor = .textPrimary
            paymentDotImage.backgroundColor = .black
            addressToPaymentLine.backgroundColor = .black
            infoLabel.textColor = .textPrimary
            infoDotImage.backgroundColor = .black
            paymentToInfoLine.backgroundColor = .black
        case .address:
            addressLabel.text = Constants.adressText
            addressLabel.textColor = .textPrimary
            addressToPaymentLine.backgroundColor = UIColor.textPrimary.withAlphaComponent(0.1)
            paymentLabel.textColor = .textPCaption
            paymentDotImage.backgroundColor = .veryLightPink
            paymentDotImage.layer.cornerRadius = infoDotImage.frame.width / 2
            paymentToInfoLine.backgroundColor = UIColor.textPrimary.withAlphaComponent(0.1)
            infoDotImage.backgroundColor = .veryLightPink
            infoDotImage.layer.cornerRadius = infoDotImage.frame.width / 2
            infoLabel.textColor = .textPCaption
        }
    }
    
}
