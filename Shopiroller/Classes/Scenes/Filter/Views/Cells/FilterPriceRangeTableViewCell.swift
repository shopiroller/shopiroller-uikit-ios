//
//  FilterPriceRangeTableViewCell.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 23.11.2021.
//

import UIKit

protocol FilterPriceRangeTableViewCellDelegate {
    func minPriceDidEndEditing(amount: Double?)
    func maxPriceDidEndEditing(amount: Double?)
}

class FilterPriceRangeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var priceRangeLabel: UILabel!
    @IBOutlet weak var minPriceTextField: UITextField!
    @IBOutlet weak var maxPriceTextField: UITextField!
    
    private var delegate: FilterPriceRangeTableViewCellDelegate?
    
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
        
        minPriceTextField.delegate = self
        maxPriceTextField.delegate = self
        minPriceTextField.rightViewMode = .always
        maxPriceTextField.rightViewMode = .always
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
    }
    
    func setup(delegate: FilterPriceRangeTableViewCellDelegate, currency: CurrencyEnum, minPrice: Double?, maxPrice: Double?) {
        self.delegate = delegate
        minPriceTextField.rightView = getCurrencyLabel(currency: currency)
        maxPriceTextField.rightView = getCurrencyLabel(currency: currency)
        if let minPrice = minPrice {
            minPriceTextField.text = String(minPrice)
        }
        if let maxPrice = maxPrice {
            maxPriceTextField.text = String(maxPrice)
        }
    }
    
    private func getCurrencyLabel(currency: CurrencyEnum) -> UILabel {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 79, height: 22))
        label.font = .bold13
        label.textColor = .textSecondary
        label.text = currency.rawValue + "      "
        label.textAlignment = .center
        return label
    }
    
    @IBAction func textFieldEditingChanged(_ textField: UITextField) {
        switch textField {
        case minPriceTextField:
            delegate?.minPriceDidEndEditing(amount: Double(minPriceTextField.text ?? ""))
        case maxPriceTextField:
            delegate?.maxPriceDidEndEditing(amount: Double(maxPriceTextField.text ?? ""))
        default:
            break
        }
    }
    
}

extension FilterPriceRangeTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        switch textField {
        case minPriceTextField:
            maxPriceTextField.becomeFirstResponder()
        default:
            break
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newLength = (textField.text ?? "").count + string.count - range.length
        return newLength <= 9
    }
}
