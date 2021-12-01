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
        priceRangeLabel.textColor = .textPrimary
        minPriceTextField.textColor = .textSecondary
        minPriceTextField.backgroundColor = .buttonLight
        maxPriceTextField.textColor = .textSecondary
        maxPriceTextField.backgroundColor = .buttonLight
        priceRangeLabel.text =  "filter_price_range".localized
        
        minPriceTextField.placeholder = "filter_price_range_lowest".localized
        maxPriceTextField.placeholder = "filter_price_range_highest".localized
        
        //minPriceTextField.delegate = self
       
        minPriceTextField.rightViewMode = .always
        maxPriceTextField.rightViewMode = .always
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
    }
    
    func setup(currency: CurrencyEnum) {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.textColor = .textSecondary
        label.text = currency.rawValue
        label.contentMode = .center
        
        minPriceTextField.rightView = label
        maxPriceTextField.rightView = label
    }
    
}


