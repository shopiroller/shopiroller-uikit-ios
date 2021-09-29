//
//  SliderCollectionViewCell.swift
//  shopiroller
//
//  Created by Görkem Gür on 26.09.2021.
//

import UIKit

class SliderCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var mainContainer: UIView!
    @IBOutlet private weak var tempLabel: UILabel!
    @IBOutlet private weak var sliderImage: UIImageView!
    
        
    override func prepareForReuse() {
        super.prepareForReuse()
        sliderImage.image = nil
    }

    public func configureUI(model: SliderSlidesModel?) {
        self.tempLabel.text = model?.id
    }
}


