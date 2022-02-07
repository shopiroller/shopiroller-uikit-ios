//
//  AddressView.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 22.10.2021.
//

import UIKit

class AddressView: SRBaseView {
    
    @IBOutlet private weak var addressTitle: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var addressImageView: UIImageView!
    

    private var type: AddressType?
    
    override func setup() {
        super.setup()
        
        self.layer.cornerRadius = 6
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.textSecondary10.cgColor
        addressLabel.textColor = .textPCaption
        addressLabel.font = .regular12
        addressTitle.font = .semiBold14
        addressTitle.textColor = .textPrimary
    }
    
    func configure(model: AddressCellModel) {
        type = model.type
        addressLabel.text = model.address 
        addressTitle.text = model.type.text
        addressImageView.image = model.image
    }
    
}

struct AddressCellModel {
    let type: AddressType
    let address: String
    let image: UIImage
}

enum AddressType: String {
    case shipping = "shipping"
    case billing = "billing"
    
    var text: String {
        switch self {
        case .billing:
            return "order_details_address_billing".localized
        case .shipping:
            return "order_details_address_delivery".localized
        }
    }
}
