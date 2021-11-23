//
//  SectionHeader.swift
//  shopiroller
//
//  Created by Görkem Gür on 12.10.2021.
//

import UIKit

@available(iOS 9.0, *)
class ProductsTitleView: UICollectionReusableView {
    
    private struct Constants {
        static var titleText: String { return "explore-title-text".localized  }
        
    }
    
     var label: UILabel = {
         let label: UILabel = UILabel()
         label.font = UIFont.init(name: "Poppins-Regular", size: 18)
         label.sizeToFit()
         return label
     }()

     override init(frame: CGRect) {
         super.init(frame: frame)
         label.text = Constants.titleText
         label.font = .headTwo
         label.textColor = .textPrimary
         addSubview(label)

         label.translatesAutoresizingMaskIntoConstraints = false
         label.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
         label.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 15).isActive = true
         label.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
