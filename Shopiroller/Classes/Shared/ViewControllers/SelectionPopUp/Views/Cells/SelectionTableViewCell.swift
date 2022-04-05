//
//  SelectionTableViewCell.swift
//  Shopiroller
//
//  Created by Görkem Gür on 7.11.2021.
//

import UIKit

class SelectionTableViewCell: UITableViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
               
        nameLabel.textColor = .black
        nameLabel.isUserInteractionEnabled = true
        
    }
    
    func configureCell(model: CountryModel) {
        nameLabel.text = model.name
    }
    
}

