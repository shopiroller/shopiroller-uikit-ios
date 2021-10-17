//
//  ProductImageSliderCell.swift
//  shopiroller
//
//  Created by Görkem Gür on 7.10.2021.
//

import UIKit
import Kingfisher
import ImageSlideshow

public class ProductImageSliderCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var productImage: UIImageView!

    public override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configurecell(images: ProductImageModel?) {
        self.productImage.kf.setImage(with: URL(string: images?.normal ?? ""))
    }
    
  
}
