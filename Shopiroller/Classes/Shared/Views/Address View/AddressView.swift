//
//  AddressView.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 22.10.2021.
//

import UIKit

class AddressView: BaseView {
    
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var address: UILabel!
    @IBOutlet private weak var addressImageView: UIImageView!

    private var type: AddressType?
    
    func setup(model: AddressCellModel){
        super.setup()
        type = model.type
        layer.cornerRadius = 6
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.textSecondary10.cgColor
        address.textColor = .textPCaption
        address.font = .regular12
        address.text = model.address
        title.textColor = .textPrimary
        title.font = .semiBold14
        title.text = model.type.text
        addressImageView.image = model.image
    }
    
}

struct AddressCellModel {
    let type: AddressType
    let address: String
    let image: UIImage
}

enum AddressType: String {
    case delivery = "delivery"
    case shipping = "shipping"
    
    var text: String {
        switch self {
        case .delivery:
            return "order_details_address_delivery".localized
        case .shipping:
            return "order_details_address_shipping".localized
        }
    }
}
