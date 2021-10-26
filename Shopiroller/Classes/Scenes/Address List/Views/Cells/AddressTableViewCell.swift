//
//  AddressTableViewCell.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 25.10.2021.
//

import UIKit

class AddressTableViewCell: UITableViewCell {
    
    
    @IBOutlet private weak var confirmView: UIView!
    @IBOutlet private weak var informationView: UIView!
    
    @IBOutlet private weak var confirmTitle: UILabel!
    @IBOutlet private weak var confirmCancelButton: UIButton!
    @IBOutlet private weak var confirmDeleteButton: UIButton!
    
    @IBOutlet private weak var informationTitle: UILabel!
    @IBOutlet weak var informationAddress: UILabel!
    
    @IBOutlet private weak var informationDeleteButton: UIButton!
    @IBOutlet private weak var informationEditButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        confirmView.layer.cornerRadius = 6
        informationView.layer.cornerRadius = 6
        
        confirmCancelButton.setTitle("address_cell_cancel".localized)
        confirmDeleteButton.setTitle("address_cell_delete".localized)
        confirmDeleteButton.layer.cornerRadius = 6
        confirmDeleteButton.backgroundColor = .textPrimary
        confirmCancelButton.setTitleColor(.textPrimary)
        confirmDeleteButton.setTitleColor(.white)
        confirmTitle.textColor = .textPCaption
        
        informationAddress.textColor = .textPCaption
        
    }
    
    func setup(model: UserShippingAddressModel) {
        confirmTitle.attributedText = ECommerceUtil.getBoldNormal(model.title ?? "", "address_cell_confirm_title".localized)
        
        informationTitle.text = model.title
        informationAddress.text = model.getListDeliveryDescriptionArea()
        
    }
    
    @IBAction func confirmCancelClicked(_ sender: Any) {
        switchViews(openConfirm: false)
        
    }
    
    @IBAction func confirmDeleteClicked(_ sender: Any) {
    }
    
    @IBAction func informationDeleteClicked(_ sender: Any) {
        switchViews(openConfirm: true)
    }
    
    @IBAction func informationEditClicked(_ sender: Any) {
    }
    
    private func switchViews(openConfirm: Bool){
        informationView.isHidden = openConfirm
        confirmView.isHidden = !openConfirm
    }
    
    
}
