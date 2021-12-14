//
//  CategoriesCollectionViewCell.swift
//  shopiroller
//
//  Created by Görkem Gür on 28.09.2021.
//

import UIKit
import Kingfisher


class CategoriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageContainer: UIView!
    @IBOutlet private weak var categoryImage: UIImageView!
    @IBOutlet private weak var categoryTitleContainer: UIView!
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet private weak var imageViewBackGround: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imageViewBackGround.layer.cornerRadius = imageViewBackGround.layer.frame.height / 2
        imageViewBackGround.backgroundColor = .buttonLight
        
        categoryTitle.font =  .regular12
        categoryTitle.textColor = .textPrimary
        
    }
    
    func configureCell(model: SRCategoryResponseModel?){
        categoryTitle.text = model?.name
        categoryImage.backgroundColor = .clear
        categoryImage.setImages(url: model?.icon ?? "")
    }    
    
}
