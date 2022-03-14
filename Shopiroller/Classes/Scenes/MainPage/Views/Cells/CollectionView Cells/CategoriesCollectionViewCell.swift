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
    @IBOutlet private weak var categoryTitle: PaddingLabel!
    @IBOutlet private weak var imageViewBackGround: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imageViewBackGround.layer.cornerRadius = imageViewBackGround.layer.frame.height / 2
        imageViewBackGround.backgroundColor = .buttonLight
        
        categoryTitle.font =  .regular12
        categoryTitle.textColor = .textPrimary
        
    }
    
    func configureCell(model: SRCategoryResponseModel?, categoryDisplayTypeEnum : CategoryDisplayTypeEnum?) {
        categoryTitle.text = model?.name
        categoryImage.backgroundColor = .clear
        
        if let categoryDisplayTypeEnum = categoryDisplayTypeEnum {
            switch categoryDisplayTypeEnum {
            case .imageAndText:
                imageContainer.isHidden = false
                categoryTitleContainer.isHidden = false
                categoryTitle.removeLayer()
                setCategoryImage(url: model?.icon ?? "")
            case .textOnly:
                categoryTitleContainer.isHidden = false
                categoryTitle.setLayer()
                imageContainer.isHidden = true
            case .imageOnly:
                categoryTitleContainer.isHidden = true
                imageContainer.isHidden = false
                categoryTitle.removeLayer()
                setCategoryImage(url: model?.icon ?? "")
            }
        } else {
            categoryTitleContainer.isHidden = false
            imageContainer.isHidden = false
            setCategoryImage(url: model?.icon ?? "")
        }
        categoryTitle.text = model?.name
    }
    
    private func setCategoryImage(url: String) {
        categoryImage.setImages(url: url)
        imageContainer.isHidden = false
        categoryTitleContainer.isHidden = false
    }
    
}
