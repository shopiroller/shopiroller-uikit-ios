//
//  SRButton.swift
//  Shopiroller
//
//  Created by Görkem Gür on 14.10.2021.
//

import Foundation


public enum SRButtonType {

    case darkButton
    case lightButton
    case clearButton
    case floatButton
    
    fileprivate var style: SRButtonStyle {
        switch self {
        case .darkButton:
            return SRButtonStyle(backgroundColor: .textPrimary , titleColor: .white)
        case .lightButton:
            return SRButtonStyle(backgroundColor: .buttonLight, titleColor: .black)
        case .clearButton:
            return SRButtonStyle(backgroundColor: .clear)
        case .floatButton:
            return SRButtonStyle(backgroundColor: .black)
        }
    }
    
    
}


public struct SRButtonStyle {
    
    let roundMultiplier: CGFloat
    let gradientColors: [CGColor]?
    let backgroundColor: UIColor?
    let borderWidth: CGFloat
    let borderColor: UIColor?
    let tintColor: UIColor?
    let titleColor: UIColor?
    let titleFont: UIFont?

    init(roundMultiplier: CGFloat = 0.13,
         gradientColors: [CGColor]? = nil,
         backgroundColor: UIColor? = .clear,
         borderWidth: CGFloat = 0.0,
         borderColor: UIColor? = .clear,
         tintColor: UIColor? = .clear,
         titleColor: UIColor? = .clear,
         titleFont: UIFont? = UIFont.boldSystemFont(ofSize: 14)) {
        self.roundMultiplier = roundMultiplier
        self.gradientColors = gradientColors
        self.backgroundColor = backgroundColor
        self.borderWidth = borderWidth
        self.borderColor = borderColor
        self.tintColor = tintColor
        self.titleColor = titleColor
        self.titleFont = titleFont
    }
    
}

public class SRButton: UIButton {
    var type: SRButtonType? {
        didSet {
            applyStyle()
        }
    }
    
    private var gradientLayer = CAGradientLayer()
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if type?.style != nil , bounds != gradientLayer.bounds {
            applyStyle()
        }
    }
    
    private func applyStyle() {
        guard let style = type?.style else {
            gradientLayer.removeFromSuperlayer()
            return
        }
        
        semanticContentAttribute = .forceLeftToRight
        
        layer.masksToBounds = true
        layer.cornerRadius = frame.size.height * style.roundMultiplier
        
        backgroundColor = style.backgroundColor
        
        layer.borderWidth = style.borderWidth
        layer.borderColor = style.borderColor?.cgColor
        
        tintColor = style.tintColor
        
        setTitleColor(style.titleColor, for: .normal)
        titleLabel?.font = style.titleFont
        titleLabel?.textAlignment = .center
        
        if type == .floatButton {
            setImage(.rightArrow, for: .normal)
            semanticContentAttribute = .forceRightToLeft
            imageEdgeInsets.left = 15
        }
    }
}
