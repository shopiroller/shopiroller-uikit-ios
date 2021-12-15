//
//  SortProductTableViewCell.swift
//  Shopiroller
//
//  Created by Görkem Gür on 15.12.2021.
//

import UIKit

protocol SortProductCellDelegate {
    func getTappedIndex(index: Int)
}

class SortProductTableViewCell: UITableViewCell {

    @IBOutlet private weak var sortByTitle: UILabel!
    @IBOutlet private weak var sortCheckedImage: UIImageView!
    
    var delegate : SortProductCellDelegate?
    private var selectedIndex : Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        sortByTitle.font = .semiBold14
        sortByTitle.textColor = .textPrimary
        
        sortCheckedImage.tintColor = .textPrimary
        sortCheckedImage.image = .strokedCheckmark
        
        let cellTapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(cellTapGesture)
    }

    
    func setup(title: String?, isChecked: Bool,index: Int?) {
        self.selectedIndex = index ?? 0
        if isChecked {
            sortCheckedImage.isHidden = false
        } else {
            sortCheckedImage.isHidden = true
        }
        sortByTitle.text = title
    }
    
    @objc func cellTapped() {
        delegate?.getTappedIndex(index: selectedIndex)
    }
    
}
