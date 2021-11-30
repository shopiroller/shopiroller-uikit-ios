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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.textColor = .textPrimary
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if(selected){
            doneIcon.isHidden = false
            titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        }
    }
    
    func setup(model: FilterChoiceTableViewModel) {
        titleLabel.text = model.name
        doneIcon.isHidden = true
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        titleLeadingConstraint.constant = 20 + CGFloat((model.depth * 10))
    }
    
}

struct FilterChoiceTableViewModel {
    let categoryId: String?
    let name: String?
    let depth: Int
}
