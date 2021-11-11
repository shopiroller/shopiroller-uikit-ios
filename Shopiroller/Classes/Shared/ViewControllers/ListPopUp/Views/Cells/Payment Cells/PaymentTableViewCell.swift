//
//  PaymentTableViewCell.swift
//  Shopiroller
//
//  Created by Görkem Gür on 9.11.2021.
//

import UIKit

class PaymentTableViewCell: UITableViewCell {

    @IBOutlet private weak var paymentTypeImage: UIImageView!
    @IBOutlet private weak var paymentTypeText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        paymentTypeText.textColor = .textPrimary
        paymentTypeText.font = UIFont.boldSystemFont(ofSize: 14)
    }

    
    
}
