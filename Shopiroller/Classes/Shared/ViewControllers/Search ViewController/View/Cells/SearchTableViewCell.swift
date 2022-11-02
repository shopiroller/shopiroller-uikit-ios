//
//  SearchTableViewCell.swift
//  Shopiroller
//
//  Created by Görkem Gür on 1.12.2021.
//

import UIKit

protocol SearchTableViewCellDelegate: AnyObject {
    func deleteButtonTapped(title : String?)
}

class SearchTableViewCell: UITableViewCell {

    @IBOutlet private weak var searchTextLabel: UILabel!
    @IBOutlet private weak var deleteButton: UIButton!
    
    private var title: String?
    
    weak var delegate : SearchTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        searchTextLabel.textColor = .textSecondary
        searchTextLabel.font = .regular12
        contentView.frame = contentView.frame.insetBy(dx: 0, dy: 30)
    }

    @IBAction func deleteButtonTapped() {
        delegate?.deleteButtonTapped(title: self.title)
    }
    
    func configureCell(title : String?) {
        self.title = title
        searchTextLabel.text = title
    }
    
}
