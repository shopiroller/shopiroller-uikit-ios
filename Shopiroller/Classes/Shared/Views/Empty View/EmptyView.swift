//
//  EmptyView.swift
//  shopiroller
//
//  Created by Görkem Gür on 23.09.2021.
//

import UIKit


protocol EmptyViewDelegate {
    func actionButtonClicked(_ sender: Any)
}

public class EmptyView: BaseView {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var actionButton: UIButton!
    
    var delegate: EmptyViewDelegate?
    
    func setup(model: EmptyModel) {
        super.setup()
        setupFromNib()
        
        imageView.image = model.image
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        descriptionLabel.textColor = .textPCaption
        
        if let button = model.button {
            actionButton.isHidden = false
            actionButton.setTitle(button.title)
            if(button.color != nil){
                actionButton.tintColor = button.color
            }
        }
    }
    
    @IBAction func actionButtonClicked(_ sender: Any) {
        delegate?.actionButtonClicked(sender)
    }
    
}

