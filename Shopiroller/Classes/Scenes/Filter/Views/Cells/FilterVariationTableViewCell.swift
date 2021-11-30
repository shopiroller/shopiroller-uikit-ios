//
//  FilterSelectionTableViewCell.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 23.11.2021.
//

import UIKit

class FilterVariationTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.textColor = .textPrimary
        selectionLabel.textColor = .textPCaption
    }
    
    func setup(model: VariationGroupsItem) {
        titleLabel.textColor = .textPrimary
        titleLabel.text = model.name
    }
    
    func setupCategory(selectedLabel: String) {
        titleLabel.text = "filter_category".localized
        if(selectedLabel.isEmpty) {
            selectionLabel.isHidden = true
        }else {
            selectionLabel.isHidden = false
            selectionLabel.text = selectedLabel
        }
    }
    
    func setupBrand() {
        titleLabel.text = "filter_brand".localized
    }
 
}
