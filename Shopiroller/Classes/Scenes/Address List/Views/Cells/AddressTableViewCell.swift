//
//  AddressTableViewCell.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 25.10.2021.
//

import UIKit

class AddressTableViewCell: UITableViewCell {

    
    @IBOutlet private weak var confirmView: UIView!
    @IBOutlet private weak var informationView: UIView!
    
    @IBOutlet private weak var confirmTitle: UILabel!
    @IBOutlet private weak var confirmCancelButton: UIButton!
    @IBOutlet private weak var confirmDeleteButton: UIButton!
    @IBOutlet private weak var informationTitle: UILabel!
    @IBOutlet private weak var informationName: UILabel!
    
    @IBOutlet private weak var informationAddress: UILabel!
    @IBOutlet private weak var informationTown: UILabel!
    @IBOutlet private weak var informationPhone: UILabel!
    @IBOutlet private weak var informationTax: UILabel!
    @IBOutlet private weak var informationDeleteButton: UIButton!
    @IBOutlet private weak var informationEditButton: UIButton!
    
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
