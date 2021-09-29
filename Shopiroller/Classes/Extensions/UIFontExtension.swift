//
//  UIFontExtension.swift
//  shopiroller
//
//  Created by Görkem Gür on 23.09.2021.
//

import UIKit

enum SRFontFamily: String, EnumDecodable {
    static var `default`: SRFontFamily {
        return .poppins
    }
    case poppins = "Poppins"
}

enum SRFont: String {
    
    case semiBold
    case regular
    case bold
    
    func font(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: name, size: fontSize)!
    }
    
    var name: String {
        var fontType: String = ""
        switch self {
        case .semiBold:
            fontType = "SemiBold"
        case .regular:
            fontType = "Regular"
        case .bold:
            fontType = "Bold"
        }
        
        return fontFamily.appending("-\(fontType)")
    }
    
    var fontFamily: String {
        return SRAppContext.fontFamily.rawValue
    }
    
}

extension UIFont {
    
    static let headOne: UIFont = SRFont.bold.font(ofSize: 24.0)
    
    static let headTwo: UIFont = SRFont.bold.font(ofSize: 18.0)
    
    static let headTwoSemiBold: UIFont = SRFont.semiBold.font(ofSize: 14.0)
    
    static let textStyle: UIFont = SRFont.regular.font(ofSize: 24.0)
    
    static let subHead: UIFont = SRFont.bold.font(ofSize: 14.0)
    
    static let pharagraph: UIFont = SRFont.regular.font(ofSize: 14.0)
    
    static let span: UIFont = SRFont.regular.font(ofSize: 12.0)
    
    class func listAllFontsOnSystem(){
        let familyNames = UIFont.familyNames
        for familyName in familyNames {
            let fontNames = UIFont.fontNames(forFamilyName: familyName)
            for fontName in fontNames {
                print(fontName)
            }
        }
    }
}
