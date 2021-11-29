//
//  FilterPriceRangeTableViewCell.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 23.11.2021.
//

import UIKit

class FilterPriceRangeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var priceRangeLabel: UILabel!
    @IBOutlet weak var minPriceTextField: UITextField!
    @IBOutlet weak var maxPriceTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        priceRangeLabel.textColor = .textPrimary
        minPriceTextField.textColor = .textSecondary
        minPriceTextField.backgroundColor = .buttonLight
        maxPriceTextField.textColor = .textSecondary
        maxPriceTextField.backgroundColor = .buttonLight
        priceRangeLabel.text =  "filter_price_range".localized
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
    }
    
    func setup() {
        
    }
    
}
