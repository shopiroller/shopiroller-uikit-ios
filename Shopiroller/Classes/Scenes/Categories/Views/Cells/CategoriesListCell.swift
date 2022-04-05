//
//  CategoriesListCell.swift
//  Shopiroller
//
//  Created by Görkem Gür on 22.10.2021.
//

import UIKit

class CategoriesListCell: UITableViewCell {
    
    private struct Constants {
        
        static var categoryItemText : String { return "category-items-text".localized }
        
    }
    
    @IBOutlet private weak var categoryNameTitle: UILabel!
    @IBOutlet private weak var descriptionContainer: UIView!
    @IBOutlet private weak var categoryImageContainer: UIView!
    @IBOutlet private weak var categoryImage: UIImageView!
    @IBOutlet private weak var rightArrowImage: UIImageView!
    @IBOutlet private weak var categoryItemCountLabel: UILabel!
    @IBOutlet private weak var categoryImageBackground: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        rightArrowImage.image = .rightArrow
        
        categoryImageBackground.layer.cornerRadius = categoryImageBackground.layer.frame.height / 2
        categoryImageBackground.backgroundColor = .buttonLight
        
    }
    
    
    
    func setupCategories(model : SRCategoryResponseModel, categoryDisplayTypeEnum: CategoryDisplayTypeEnum?) {
        
        if let categoryDisplayTypeEnum = categoryDisplayTypeEnum {
            switch categoryDisplayTypeEnum {
            case .imageAndText:
                categoryImageContainer.isHidden = false
                categoryNameTitle.isHidden = false
                setCategoryImage(url: model.icon ?? "")
            case .textOnly:
                categoryNameTitle.isHidden = false
                categoryImageContainer.isHidden = true
            case .imageOnly:
                categoryNameTitle.isHidden = true
                categoryImageContainer.isHidden = false
                setCategoryImage(url: model.icon ?? "")
            }
        } else {
            categoryNameTitle.isHidden = false
            categoryImageContainer.isHidden = false
            setCategoryImage(url: model.icon ?? "")
        }
        
        categoryNameTitle.text = model.name
        categoryItemCountLabel.text = Constants.categoryItemText.replacingOccurrences(of: "XX", with: String(model.totalProducts ?? 0))
    }
    
    private func setCategoryImage(url: String) {
        categoryImage.setImages(url: url)
        categoryImageContainer.isHidden = false
        categoryNameTitle.isHidden = false
    }
    
}
