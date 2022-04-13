//
//  AddressSelectTableViewCell.swift
//  Shopiroller
//
//  Created by Görkem Gür on 9.11.2021.
//

import UIKit

class AddressSelectTableViewCell: UITableViewCell {
    @IBOutlet private weak var addressTitle: UILabel!
    @IBOutlet private weak var addressFirstLine: UILabel!
    @IBOutlet private weak var addressSecondLine: UILabel!
    @IBOutlet private weak var addressThirdLine: UILabel!
    @IBOutlet private weak var rightArrowImage: UIImageView!
    @IBOutlet private weak var divider: UIView!
    
    
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
        
    }

    func setupBillingCell(model: UserBillingAdressModel?, showDivider: Bool){
        addressTitle.text = model?.title
        addressFirstLine.text = model?.getPopupAddressFirstLine()
        addressSecondLine.text = model?.getPopupAddressSecondLine()
        addressThirdLine.text = model?.getPopupAddressThirdLine()
        divider.isHidden = !showDivider
    }
    
    func setupShippingCell(model: UserShippingAddressModel?, showDivider: Bool){
        addressTitle.text = model?.title
        addressFirstLine.text = model?.getPopupAddressFirstLine()
        addressSecondLine.text = model?.getPopupAddressSecondLine()
        addressThirdLine.text = model?.getPopupAddressThirdLine()
        divider.isHidden = !showDivider
    }
    
}
