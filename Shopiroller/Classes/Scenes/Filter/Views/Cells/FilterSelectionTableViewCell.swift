//
//  FilterSelectionTableViewCell.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 23.11.2021.
//

import UIKit

class FilterSelectionTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.textColor = .textPrimary
    }
    
    func setup(model: VariationGroupsItem) {
        titleLabel.textColor = .textPrimary
        titleLabel.text = model.name
    }
    
    func setupCategory() {
        titleLabel.text = "filter_category".localized
    }
    
    func setupBrand() {
        titleLabel.text = "filter_brand".localized
    }
 
}
