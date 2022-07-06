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
    
    func setup(model: VariationGroups, selectionLabel: String) {
        titleLabel.text = model.name
        setSelectionLabel(selectionLabel: selectionLabel)
    }
    
    func setupCategory(selectionLabel: String) {
        titleLabel.text = "e_commerce_filter_category".localized
        setSelectionLabel(selectionLabel: selectionLabel)
    }
    
    func setupBrand(selectionLabel: String) {
        titleLabel.text = "e_commerce_filter_brand".localized
        setSelectionLabel(selectionLabel: selectionLabel)
    }
    
    private func setSelectionLabel(selectionLabel: String) {
        if(selectionLabel.isEmpty) {
            self.selectionLabel.isHidden = true
        }else {
            self.selectionLabel.isHidden = false
            self.selectionLabel.text = selectionLabel
        }
    }
 
}
