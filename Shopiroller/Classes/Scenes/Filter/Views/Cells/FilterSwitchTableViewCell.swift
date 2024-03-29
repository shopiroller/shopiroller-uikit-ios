//
//  FilterSwitchTableViewCell.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 24.11.2021.
//

import UIKit

protocol FilterSwitchTableViewCellDelegate {
    func checkedChanged(type: FilterSwitchType, isOn: Bool)
}

class FilterSwitchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cellSwitch: UISwitch!
    
    private var type: FilterSwitchType?
    private var delegate: FilterSwitchTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.textColor = .textPrimary
        cellSwitch.tintColor = .textPrimary
    }
    
    func setup(type: FilterSwitchType, delegate: FilterSwitchTableViewCellDelegate, isOn: Bool) {
        self.type = type
        self.delegate = delegate
        titleLabel.text = getTitleLabel()
        cellSwitch.setOn(isOn, animated: false)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
    }
    
    @IBAction func cellSwitchChanged(_ sender: Any) {
        guard let type = type else {
            return
        }
        delegate?.checkedChanged(type: type, isOn: cellSwitch.isOn)
    }
    
    private func getTitleLabel() -> String? {
            switch type {
            case .stockSwitch:
                return "e_commerce_stock_only".localized
            case .discountedProductsSwitch:
                return "e_commerce_discounted_products".localized
            case .freeShippingSwitch:
                return "e_commerce_free_shipping".localized
            default:
                return nil
            }
    }
    
}

enum FilterSwitchType {
    case stockSwitch, discountedProductsSwitch, freeShippingSwitch
}
