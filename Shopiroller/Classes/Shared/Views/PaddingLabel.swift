//
//  PaddingLabel.swift
//  Shopiroller
//
//  Created by Görkem Gür on 4.03.2022.
//

import Foundation

@IBDesignable class PaddingLabel: UILabel {
    
    enum ProductLabelType {
        case soldOut,freeShipping
    }

    @IBInspectable var topInset: CGFloat = 5.0
    @IBInspectable var bottomInset: CGFloat = 5.0
    @IBInspectable var leftInset: CGFloat = 5.0
    @IBInspectable var rightInset: CGFloat = 5.0

    override func drawText(in rect: CGRect) {
        self.layer.cornerRadius = 6
        self.layer.masksToBounds = true
        super.drawText(in: rect.offsetBy(dx: 0, dy: 0))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
    
    func removeLayer() {
        self.backgroundColor = .white
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 0
    }
    
    func setLayer() {
        self.backgroundColor = .lightGray
    }
    
    func setProductSituation(type: ProductLabelType) {
        switch type {
        case .soldOut:
            self.backgroundColor = .badgeSecondary
        case .freeShipping:
            self.backgroundColor = .textPrimary
        }
    }
}
