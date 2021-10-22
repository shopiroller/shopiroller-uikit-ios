//
//  AddressView.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 22.10.2021.
//

import UIKit
extension AddressView : NibLoadable { }
class AddressView: BaseView {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var addressImage: UIImageView!
    
    func setup(model: AddressCellModel){
        super.setup()
        setupFromNib()
        
        layer.cornerRadius = 6
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.textSecondary10.cgColor
        title.text = model.title
        address.text = model.address
        addressImage.image = model.image
    }

}

struct AddressCellModel {
    let title: String
    let address: String
    let image: UIImage
}
