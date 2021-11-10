//
//  GeneralAddressView.swift
//  Shopiroller
//
//  Created by Görkem Gür on 3.11.2021.
//

import Foundation
import UIKit

extension GeneralAddressView : NibLoadable { }

protocol GeneralAddressDelegate {
    func editButtonTapped(type: GeneralAddressType)
    func selectOtherAdressButtonTapped(type: GeneralAddressType?)
}

public class GeneralAddressView: BaseView {
    
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
        setupFromNib()
        
        type = model.type
        
        containerView.backgroundColor = .buttonLight
        containerView.layer.cornerRadius = 8
        containerView.layer.masksToBounds = true
                
        selectOtherAddressButton.setTitle(Constants.selectOtherAdressButtonText)
        selectOtherAddressButton.tintColor = .textPrimary
        selectOtherAddressButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        
        titleLabel.textColor = .textPrimary
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
    
        addressLine.textColor = .textPCaption
        addressLine.font = UIFont.systemFont(ofSize: 12)
        
        descriptionArea.textColor = .textPCaption
        descriptionArea.font = UIFont.systemFont(ofSize: 12)
        
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


