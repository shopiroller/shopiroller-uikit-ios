//
//  EmptyView.swift
//  shopiroller
//
//  Created by Görkem Gür on 23.09.2021.
//

import UIKit


protocol EmptyViewDelegate {
    func actionButtonClicked(_ sender: Any)
}

protocol EmptyViewAddressDelegate {
    func addAddressButtonClicked(type: GeneralAddressType?)
}

public class EmptyView: BaseView {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var actionButton: UIButton!
    @IBOutlet private weak var buttonContainer: UIView!
    
    var delegate: EmptyViewDelegate?
    
    var addressDelegate : EmptyViewAddressDelegate?
    
    private var type : GeneralAddressType? = .shipping
    
    func setup(model: EmptyModel) {
        super.setup()
        
        imageView.image = model.image
        titleLabel.text = model.title
        descriptionLabel.textColor = .textPCaption
        
        if model.image == .emptyShippingAddresses {
            type = .shipping
        } else {
            type = .billing
        }
        
        if let description = model.description {
            descriptionLabel.isHidden = false
            descriptionLabel.text = description
        }
        
        if let button = model.button {
            buttonContainer.isHidden = false
            actionButton.setTitle(button.title)
            actionButton.setTitleColor(.white)
            if(button.color != nil){
                buttonContainer.backgroundColor = button.color
            }
        }
    }
    
    @IBAction func actionButtonClicked(_ sender: Any) {
        delegate?.actionButtonClicked(sender)
    }
    
    @IBAction func addAddressButtonClicked(_ sender: Any){
        addressDelegate?.addAddressButtonClicked(type: self.type)
    }
    
}

