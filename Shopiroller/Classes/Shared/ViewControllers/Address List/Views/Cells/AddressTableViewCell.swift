//
//  AddressTableViewCell.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 25.10.2021.
//

import UIKit

protocol AddressTableViewCellDelegate: AnyObject {
    func deleteButtonClicked(indexPathRow: Int?)
    func editButtonClicked(indexPathRow: Int?)
}

class AddressTableViewCell: UITableViewCell {
    
    
    @IBOutlet private weak var confirmView: UIView!
    @IBOutlet private weak var informationView: UIView!
    
    @IBOutlet private weak var confirmTitle: UILabel!
    @IBOutlet private weak var confirmCancelButton: UIButton!
    @IBOutlet private weak var confirmDeleteButton: UIButton!
    
    @IBOutlet private weak var informationTitle: UILabel!
    @IBOutlet private weak var informationAddress: UILabel!
    
    @IBOutlet private weak var informationDeleteButton: UIButton!
    @IBOutlet private weak var informationEditButton: UIButton!
    
    weak var delegate: AddressTableViewCellDelegate?
    
    private var indexPathRow: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        confirmView.layer.cornerRadius = 6
        informationView.layer.cornerRadius = 6
        
        confirmCancelButton.setTitle("user_my_address_delete_address_cancel_button".localized)
        confirmCancelButton.setTitleColor(.textPrimary)
        confirmCancelButton.titleLabel?.font = .semiBold14
        
        confirmDeleteButton.setTitle("user_my_address_delete_address_delete_button".localized)
        confirmDeleteButton.setTitleColor(.white)
        confirmDeleteButton.layer.cornerRadius = 6
        confirmDeleteButton.backgroundColor = .textPrimary
        confirmDeleteButton.titleLabel?.font = .semiBold14
        
        confirmTitle.textColor = .textPCaption
        confirmTitle.font = .regular12
        
        informationTitle.textColor = .textPrimary
        informationTitle.font = .semiBold14
        
        informationAddress.textColor = .textPCaption
        informationAddress.font = .regular12
    }
    
    func setup(model: UserBillingAdressModel, indexPathRow: Int) {
        self.indexPathRow = indexPathRow
        confirmTitle.attributedText = NSAttributedString(format: NSAttributedString(string: "user_my_address_delete_address_title".localized), args: ECommerceUtil.getBoldNormal(model.title ?? "", ""))
        informationTitle.text = model.title
        informationAddress.text = model.getListBillingDescriptionArea()
    }
    
    func setup(model: UserShippingAddressModel, indexPathRow: Int) {
        self.indexPathRow = indexPathRow
        confirmTitle.attributedText = NSAttributedString(format: NSAttributedString(string: "user_my_address_delete_address_title".localized), args: ECommerceUtil.getBoldNormal(model.title ?? "", ""))
        informationTitle.text = model.title
        informationAddress.text = model.getListDeliveryDescriptionArea()
    }
    
    @IBAction func confirmCancelClicked(_ sender: Any) {
        switchViews(openConfirm: false)
    }
    
    @IBAction func confirmDeleteClicked(_ sender: Any) {
        delegate?.deleteButtonClicked(indexPathRow: indexPathRow)
    }
    
    @IBAction func informationDeleteClicked(_ sender: Any) {
        switchViews(openConfirm: true)
    }
    
    @IBAction func informationEditClicked(_ sender: Any) {
        delegate?.editButtonClicked(indexPathRow: indexPathRow)
    }
    
    private func switchViews(openConfirm: Bool){
        informationView.isHidden = openConfirm
        confirmView.isHidden = !openConfirm
    }
    
    
}
