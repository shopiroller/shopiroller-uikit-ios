//
//  GeneralAddressView.swift
//  Shopiroller
//
//  Created by Görkem Gür on 3.11.2021.
//

import Foundation
import UIKit


protocol GeneralAddressDelegate {
    func editButtonTapped(type: GeneralAddressType)
    func selectOtherAdressButtonTapped(type: GeneralAddressType?)
}

public class GeneralAddressView: SRBaseView {
    
    private struct Constants {
        
        static var selectOtherAdressButtonText: String { return "select-other-address-button-text".localized }
    }
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var addressLine: UILabel!
    @IBOutlet private weak var descriptionArea: UILabel!
    @IBOutlet private weak var editAddressButton: UIButton!
    @IBOutlet private weak var selectOtherAddressButton: UIButton!
    
    
    var delegate: GeneralAddressDelegate?
    
    var type: GeneralAddressType?
        
    func setup(model: GeneralAddressModel) {
        super.setup()
        
        type = model.type
        
        containerView.backgroundColor = .buttonLight
        containerView.layer.cornerRadius = 8
        containerView.layer.masksToBounds = true
                
        selectOtherAddressButton.setTitle(Constants.selectOtherAdressButtonText)
        selectOtherAddressButton.tintColor = .textPrimary
        selectOtherAddressButton.titleLabel?.font = .medium12
        
        titleLabel.textColor = .textPrimary
        titleLabel.font = .semiBold14
    
        addressLine.textColor = .textPCaption
        addressLine.font = .regular12
        addressLine.adjustsFontSizeToFitWidth = false
        addressLine.lineBreakMode = NSLineBreakMode.byTruncatingTail

        descriptionArea.textColor = .textPCaption
        descriptionArea.font = .regular12
        descriptionArea.adjustsFontSizeToFitWidth = false
        descriptionArea.lineBreakMode = NSLineBreakMode.byTruncatingTail

        
        editAddressButton.setImage(UIImage(systemName: "pencil"))
        editAddressButton.tintColor = .black
        
        if model.isEmpty {
            selectOtherAddressButton.isHidden = true
            containerView.isHidden = true
        }else {
            selectOtherAddressButton.isHidden = false
            containerView.isHidden = false
            titleLabel.text = model.title
            addressLine.text = model.address
            descriptionArea.text = model.description
        }
        
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        if type == .shipping {
            delegate?.editButtonTapped(type: .shipping)
        } else {
            delegate?.editButtonTapped(type: .billing)
        }
    }
    
    @IBAction func selectOtherAddressButtonTapped(_ sender: Any) {
        delegate?.selectOtherAdressButtonTapped(type: self.type)
    }
    
}


