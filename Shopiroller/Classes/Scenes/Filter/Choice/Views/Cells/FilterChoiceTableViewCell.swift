//
//  FilterSelectionTableViewCell.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 25.11.2021.
//

import UIKit

class FilterChoiceTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var doneIcon: UIImageView!
    @IBOutlet weak var titleLeadingConstraint: NSLayoutConstraint!
    
    private var isCheckBox: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.textColor = .textPrimary
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if(selected) {
            titleLabel.font = .semiBold14
            if(isCheckBox) {
                doneIcon.image = .checkBoxChecked
            } else {
                doneIcon.isHidden = false
            }
        } else {
            titleLabel.font = .regular14
            if(isCheckBox) {
                doneIcon.image = .checkBoxUnchecked
            } else {
                doneIcon.isHidden = true
            }
        }
    }
    
    func setup(model: FilterChoiceTableModel, isCheckBox: Bool) {
        self.isCheckBox = isCheckBox
        titleLabel.text = model.name
        titleLeadingConstraint.constant = 20 + CGFloat((model.depth * 10))
    }
    
}

struct FilterChoiceTableModel {
    let id: String
    let name: String
    let depth: Int
}
