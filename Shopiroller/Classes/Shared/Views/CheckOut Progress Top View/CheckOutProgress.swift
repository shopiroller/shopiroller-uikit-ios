//
//  CheckOutProgress.swift
//  Shopiroller
//
//  Created by Görkem Gür on 1.11.2021.
//

import Foundation


class CheckOutProgress : BaseView {

    private struct Constants {
        static var adressText: String { return "address-text".localized }
        static var paymentText: String { return "payment-text".localized }
        static var infoText: String { return "info-text".localized }
        
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
        addressLabel.font = UIFont.systemFont(ofSize: 12.0)
        addressLabel.textColor = .textPrimary
        addressToPaymentLine.backgroundColor = UIColor.textPrimary.withAlphaComponent(0.1)
        
        addressDotImage.backgroundColor = .black
        addressDotImage.layer.cornerRadius = addressDotImage.frame.width / 2
        
        paymentLabel.text = Constants.paymentText
        paymentLabel.font = UIFont.systemFont(ofSize: 12.0)
        paymentLabel.textColor = .textPCaption
        paymentToInfoLine.backgroundColor = UIColor.textPrimary.withAlphaComponent(0.1)
        
        paymentDotImage.backgroundColor = .veryLightPink
        paymentDotImage.layer.cornerRadius = paymentDotImage.frame.width / 2
        
        infoLabel.textColor = .textPCaption
        infoLabel.font = UIFont.systemFont(ofSize: 12.0)
        infoLabel.text = Constants.infoText
        
        infoDotImage.backgroundColor = .veryLightPink
        infoDotImage.layer.cornerRadius = infoDotImage.frame.width / 2
        
      

      

    }
    
    func configureView(stage: ProgressStageEnum){
        switch stage {
        case .payment:
            paymentLabel.textColor = .textPrimary
            paymentDotImage.backgroundColor = .black
            paymentToInfoLine.backgroundColor = UIColor.textPrimary.withAlphaComponent(0.1)
            addressToPaymentLine.backgroundColor = .black
            infoDotImage.backgroundColor = .veryLightPink
            infoDotImage.layer.cornerRadius = infoDotImage.frame.width / 2
            infoLabel.textColor = .textPCaption
            infoLabel.font = UIFont.systemFont(ofSize: 12.0)
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
            addressLabel.font = UIFont.systemFont(ofSize: 12.0)
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
