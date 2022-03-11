//
//  PaddingLabel.swift
//  Shopiroller
//
//  Created by Görkem Gür on 4.03.2022.
//

import Foundation

@IBDesignable class PaddingLabel: UILabel {

    @IBInspectable var topInset: CGFloat = 5.0
    @IBInspectable var bottomInset: CGFloat = 5.0
    @IBInspectable var leftInset: CGFloat = 5.0
    @IBInspectable var rightInset: CGFloat = 5.0

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
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
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 6
    }
}
