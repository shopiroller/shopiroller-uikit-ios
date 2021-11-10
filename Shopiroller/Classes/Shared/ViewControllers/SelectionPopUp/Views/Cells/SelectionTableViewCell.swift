//
//  SelectionTableViewCell.swift
//  Shopiroller
//
//  Created by Görkem Gür on 7.11.2021.
//

import UIKit

protocol CellNameTapped: AnyObject {
    func getName(name: String?)
    func getId(id: String?)
}

class SelectionTableViewCell: UITableViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    
    var delegate: CellNameTapped?
    private var model: CountryModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        let gesture = UITapGestureRecognizer(target: self, action: #selector(nameTapped))
        
        nameLabel.textColor = .black
        nameLabel.isUserInteractionEnabled = true
        nameLabel.addGestureRecognizer(gesture)
        
    }
    
    func configureCell(model: CountryModel) {
        self.model = model
        nameLabel.text = model.name
    }
    
    @objc func nameTapped() {
        delegate?.getName(name: nameLabel.text)
        delegate?.getId(id: model?.id ?? "")
    }
    
    
    
    
}

