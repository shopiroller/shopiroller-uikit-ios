//
//  ProductImageSliderCell.swift
//  shopiroller
//
//  Created by Görkem Gür on 7.10.2021.
//

import UIKit
import Kingfisher

public class ProductImageSliderCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var productImage: UIImageView!

    public override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configurecell(images: ProductImageModel?) {
        productImage.setImages(url: images?.normal ?? "")
    }
    
}
