//
//  ProductsTitleView.swift
//  Kingfisher
//
//  Created by Görkem Gür on 6.10.2021.
//

import UIKit

@available(iOS 8.2, *)

class ProductsTitleView: UICollectionReusableView {
    static let identifier = "ProductsTitleView"
     private let label: UILabel = {
         let label = UILabel()
         label.textColor = .black
         label.text = "Products"
         label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
         label.textAlignment = .left
         return label
     }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addSubview(label)

    }

}
