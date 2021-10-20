//
//  ProductImageSliderCellCollectionViewCell.swift
//  Kingfisher
//
//  Created by Görkem Gür on 7.10.2021.
//

import UIKit

public class ProductImageSliderCellCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var productImage: UIImageView!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        let biggerImageGesture = UITapGestureRecognizer(target: self, action: #selector(seeBigPicture))
        productImage.addGestureRecognizer(biggerImageGesture)
        
        productImage.image = .paymentFailed
    }
    
    @objc func seeBigPicture() {
        
    }
    

}
