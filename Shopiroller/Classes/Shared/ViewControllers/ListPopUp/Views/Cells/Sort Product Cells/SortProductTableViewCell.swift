//
//  SortProductTableViewCell.swift
//  Shopiroller
//
//  Created by Görkem Gür on 15.12.2021.
//

import UIKit

class SortProductTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var sortByTitle: UILabel!
    @IBOutlet private weak var sortCheckedImage: UIImageView!
    
    private var selectedIndex : Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        sortByTitle.font = .semiBold14
        sortByTitle.textColor = .textPrimary
        
        sortCheckedImage.tintColor = .textPrimary
        
    }
    
    
    func setup(title: String?, isChecked: Bool,index: Int?) {
        self.selectedIndex = index ?? 0
        sortCheckedImage.isHidden = isChecked ? false : true
        sortByTitle.text = title
    }
    
}
