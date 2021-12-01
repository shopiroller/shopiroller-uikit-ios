//
//  SearchTableViewCell.swift
//  Shopiroller
//
//  Created by Görkem Gür on 1.12.2021.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet private weak var searchTextLabel: UILabel!
    @IBOutlet private weak var deleteButton: UIButton!
    
    private var title: String? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        searchTextLabel.textColor = .textSecondary
        searchTextLabel.font = .regular12
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0))
    }

    @IBAction func deleteButtonTapped() {
        print(title)
    }
    
    func configureCell(title : String?){
        self.title = title
    }
    
}
