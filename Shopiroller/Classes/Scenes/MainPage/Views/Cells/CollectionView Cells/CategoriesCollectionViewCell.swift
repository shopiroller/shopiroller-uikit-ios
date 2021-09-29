//
//  CategoriesCollectionViewCell.swift
//  shopiroller
//
//  Created by Görkem Gür on 28.09.2021.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var imageContainer: UIView!
    @IBOutlet private weak var categoryImage: UIImageView!
    @IBOutlet private weak var categoryTitleContainer: UIView!
    @IBOutlet private weak var categoryTitle: UILabel!
    @IBOutlet private weak var imageViewBackGround: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imageViewBackGround.layer.cornerRadius = 25
        imageViewBackGround.backgroundColor = .buttonLight
        
//        categoryImage.image = .
    }
    
    func configureCell(model: SRCategoryResponseModel?){
        categoryTitle.text = model?.name
    }

}
