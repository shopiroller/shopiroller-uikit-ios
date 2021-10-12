//
//  EmptyView.swift
//  shopiroller
//
//  Created by Görkem Gür on 23.09.2021.
//

import UIKit

extension EmptyView : NibLoadable { }

public class EmptyView: BaseView {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var button: UIButton!
    
    override func setup() {
        super.setup()
        
        setupFromNib()
    }
    
    func setupEmptyView(viewModel: EmptyViewModel) {
        if let image = viewModel.image {
            imageView.image = image
        }
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        descriptionLabel.textColor = .textPCaption
        if let buttonTitle = viewModel.buttonTitle {
            button.isHidden = false
            button.setTitle(buttonTitle)
            button.backgroundColor = viewModel.buttonColor
        }
        
    }
    

    
}

