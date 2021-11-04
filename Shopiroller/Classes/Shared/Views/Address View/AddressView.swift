//
//  AddressView.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 22.10.2021.
//

import UIKit

class AddressView: BaseView {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var addressImageView: UIImageView!

    private var type: AddressType?
    
    func setup(model: AddressCellModel){
        super.setup()
        setupFromNib()
        type = model.type
        layer.cornerRadius = 6
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.textSecondary10.cgColor
        address.textColor = .textPCaption
        title.text = model.type.text
        address.text = model.address
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
