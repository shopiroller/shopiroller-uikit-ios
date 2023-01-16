//
//  ChildVariantCollectionViewCell.swift
//  Braintree
//
//  Created by Görkem Gür on 11.01.2023.
//

import UIKit

class ChildVariantCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var variantSelectionButton: UIButton!
    @IBOutlet private weak var crossedView: CustomDiagonalLineView!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.makeCardView()
        containerView.layer.borderWidth = 1
        
    }
    
    func setup(model: Variation, isLayoutGroupActive: Bool, isBaseVariantGroup: Bool) {
        
        variantSelectionButton.setTitle(model.value, for: .normal)
        
        variantSelectionButton.setTitleColor(.lightGray, for: .disabled)
        variantSelectionButton.setTitleColor(.black, for: .normal)
        
        variantSelectionButton.isUserInteractionEnabled = false
        
        if (!isLayoutGroupActive) {
            variantSelectionButton.isEnabled = false
        } else {
            if (model.isAvailable == false) {
                crossedView.isHidden = false
                variantSelectionButton.isEnabled = false
            } else {
                variantSelectionButton.isEnabled = true
                crossedView.isHidden = true
            }
        }
        
        if (!isBaseVariantGroup) {
            if (model.isAvailable == false) {
                crossedView.isHidden = false
                variantSelectionButton.isEnabled = false
            } else {
                variantSelectionButton.isEnabled = true
                crossedView.isHidden = true
            }
        } else {
            crossedView.isHidden = true
            variantSelectionButton.isEnabled = true
        }

        if (model.isSelected) {
            containerView.layer.borderWidth = 2
        } else {
            containerView.layer.borderWidth = 1
        }
    }
    
}
