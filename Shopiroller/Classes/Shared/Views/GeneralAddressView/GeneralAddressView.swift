//
//  GeneralAddressView.swift
//  Shopiroller
//
//  Created by Görkem Gür on 3.11.2021.
//

import Foundation
import UIKit


protocol GeneralAddressDelegate {
    func editButtonTapped()
    func addAddressButtonTapped(type: GeneralAddressType?)
    func selectOtherAdressButtonTapped(type: GeneralAddressType?)
}

public class GeneralAddressView: BaseView {
    
    private struct Constants {
      
        static var deliveryAddressText: String { return "delivery-address-title".localized }
        
        static var billingAddressText: String { return "billing-address-title".localized }
        
        static var addAddressButtonText: String { return "add-address-button-text".localized }

        static var selectOtherAdressButtonText: String { return "select-other-address-button-text".localized }
    }
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var containerLabel: UILabel!
    @IBOutlet private weak var addAddressButton: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var addressLine: UILabel!
    @IBOutlet private weak var descriptionArea: UILabel!
    @IBOutlet private weak var editAddressButton: UIButton!
    @IBOutlet private weak var selectOtherAddressButton: UIButton!
    
    
    var delegate: GeneralAddressDelegate?
    
    var type: GeneralAddressType?
    
    func setup(model: GeneralAddressModel) {
        super.setup()
        setupFromNib()
        
        type = model.type
        
        addAddressButton.setTitle(Constants.addAddressButtonText)
        
        selectOtherAddressButton.setTitle(Constants.selectOtherAdressButtonText)
        
        switch model.type {
        case .shipping:
            containerLabel.text = Constants.deliveryAddressText
        case .billing:
            containerLabel.text = Constants.billingAddressText
        case .none:
            break
        }
        
        titleLabel.textColor = .textPCaption
        titleLabel.font = UIFont.systemFont(ofSize: 12)
    
        addressLine.textColor = .textPCaption
        addressLine.font = UIFont.systemFont(ofSize: 12)
        
        descriptionArea.textColor = .textPCaption
        descriptionArea.font = UIFont.systemFont(ofSize: 12)
        
        editAddressButton.setImage(UIImage(systemName: "pencil"))
        editAddressButton.tintColor = .black
        
        if model.isEmpty {
            selectOtherAddressButton.isHidden = true
            addAddressButton.isHidden = true
            containerView.isHidden = true
        }else {
            containerView.isHidden = false
            titleLabel.text = model.title
            addressLine.text = model.address
            addressLine.adjustsFontSizeToFitWidth = false
            addressLine.lineBreakMode = .byTruncatingMiddle
            descriptionArea.text = model.description
        }
        
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        delegate?.editButtonTapped()
    }
    
    @IBAction func addAddressButtonTapped(_ sender: Any) {
        delegate?.addAddressButtonTapped(type: self.type)
    }
    
    @IBAction func selectOtherAddressButtonTapped(_ sender: Any) {
        delegate?.selectOtherAdressButtonTapped(type: self.type)
    }
    
}


