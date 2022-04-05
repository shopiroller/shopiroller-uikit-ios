//
//  AddressSelectTableViewCell.swift
//  Shopiroller
//
//  Created by Görkem Gür on 9.11.2021.
//

import UIKit

protocol AddressPopUpSelectedDelegate {
    func getIndex(shippingAddressIndex : Int? , billingAddressIndex: Int?)
}

class AddressSelectTableViewCell: UITableViewCell {
    @IBOutlet private weak var addressTitle: UILabel!
    @IBOutlet private weak var addressFirstLine: UILabel!
    @IBOutlet private weak var addressSecondLine: UILabel!
    @IBOutlet private weak var addressThirdLine: UILabel!
    @IBOutlet private weak var rightArrowImage: UIImageView!
    @IBOutlet private weak var divider: UIView!
    
    private var billingAddressIndex : Int?
    private var shippingAddressIndex: Int?
    
    var delegate : AddressPopUpSelectedDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addressTitle.textColor = .textPrimary
        addressTitle.font = .semiBold14
        
        addressFirstLine.textColor = .textPCaption
        addressFirstLine.font = .regular12
        addressFirstLine.lineBreakMode = .byTruncatingTail
    
        addressSecondLine.textColor = .textPCaption
        addressSecondLine.font = .regular12
        addressSecondLine.adjustsFontSizeToFitWidth = false
        addressSecondLine.lineBreakMode = .byTruncatingTail
        
        addressThirdLine.textColor = .textPCaption
        addressThirdLine.font = .regular12
        addressThirdLine.adjustsFontSizeToFitWidth = false
        addressThirdLine.lineBreakMode = .byTruncatingTail
        
        divider.backgroundColor = .textPrimary.withAlphaComponent(0.5)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGesture)
        tapGesture.delegate = self
        
        
    }

    func setupBillingCell(model: UserBillingAdressModel?, index: Int,showDivider: Bool){
        addressTitle.text = model?.title
        addressFirstLine.text = model?.getPopupAddressFirstLine()
        addressSecondLine.text = model?.getPopupAddressSecondLine()
        addressThirdLine.text = model?.getPopupAddressThirdLine()
        billingAddressIndex = index
        divider.isHidden = !showDivider
    }
    
    func setupShippingCell(model: UserShippingAddressModel?, index: Int,showDivider: Bool){
        addressTitle.text = model?.title
        addressFirstLine.text = model?.getPopupAddressFirstLine()
        addressSecondLine.text = model?.getPopupAddressSecondLine()
        addressThirdLine.text = model?.getPopupAddressThirdLine()
        shippingAddressIndex = index
        divider.isHidden = !showDivider
    }
    
    @objc func cellTapped() {
        delegate?.getIndex(shippingAddressIndex: shippingAddressIndex, billingAddressIndex: billingAddressIndex)
    }
    
}
