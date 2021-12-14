//
//  SliderCollectionViewCell.swift
//  shopiroller
//
//  Created by Görkem Gür on 26.09.2021.
//

import UIKit
import Kingfisher

class SliderCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var mainContainer: UIView!
    @IBOutlet private weak var sliderImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        sliderImage.layer.cornerRadius = 10
        sliderImage.layer.masksToBounds = true
        
    }

    
    public func configureUI(model: SliderSlidesModel?) {
        sliderImage.setImages(url:  model?.imageUrl ?? "")
    }
}


