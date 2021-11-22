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
    case medium
    
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
        case .medium:
            fontType = "Medium"
        }
        
        return fontFamily.appending("-\(fontType)")
    }
    
    var fontFamily: String {
        return SRAppContext.fontFamily.rawValue
    }
    
    
    
}
enum RegisterFontError: Error {
  case invalidFontFile
  case fontPathNotFound
  case initFontError
  case registerFailed
}
class GetBundle {}

extension UIFont {
    static func register(path: String, fileNameString: String, type: String) throws {
      let frameworkBundle = Bundle(for: GetBundle.self)
      guard let resourceBundleURL = frameworkBundle.path(forResource: fileNameString, ofType: type) else {
         throw RegisterFontError.fontPathNotFound
      }
      guard let fontData = NSData(contentsOfFile: resourceBundleURL),    let dataProvider = CGDataProvider.init(data: fontData) else {
        throw RegisterFontError.invalidFontFile
      }
      guard let fontRef = CGFont.init(dataProvider) else {
         throw RegisterFontError.initFontError
      }
      var errorRef: Unmanaged<CFError>? = nil
     guard CTFontManagerRegisterGraphicsFont(fontRef, &errorRef) else   {
           throw RegisterFontError.registerFailed
      }
     }
}

extension UIFont {
    
    static let headOne: UIFont = SRFont.bold.font(ofSize: 24.0)
    
    static let headTwo: UIFont = SRFont.bold.font(ofSize: 18.0)
    
    static let headTwoSemiBold: UIFont = SRFont.semiBold.font(ofSize: 14.0)
    
    static let textStyle: UIFont = SRFont.regular.font(ofSize: 24.0)
    
    static let regular12: UIFont = SRFont.regular.font(ofSize: 12.0)
    
    static let medium12: UIFont = SRFont.medium.font(ofSize: 12.0)
    
    static let semiBold12: UIFont = SRFont.semiBold.font(ofSize: 12.0)
    
    static let subHead: UIFont = SRFont.bold.font(ofSize: 14.0)
    
    static let pharagraph: UIFont = SRFont.regular.font(ofSize: 14.0)
    
    static let span: UIFont = SRFont.regular.font(ofSize: 12.0)
    
    static let badgeText: UIFont = SRFont.bold.font(ofSize: 9.0)
    
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

public extension UIFont {

    public static func jbs_registerFont(withFilenameString filenameString: String, bundle: Bundle) {

        print(filenameString)
        
        guard let pathForResourceString = bundle.path(forResource: filenameString, ofType: nil) else {
            print("UIFont+:  Failed to register font - path for resource not found.")
            return
        }

        guard let fontData = NSData(contentsOfFile: pathForResourceString) else {
            print("UIFont+:  Failed to register font - font data could not be loaded.")
            return
        }

        guard let dataProvider = CGDataProvider(data: fontData) else {
            print("UIFont+:  Failed to register font - data provider could not be loaded.")
            return
        }

        guard let font = CGFont(dataProvider) else {
            print("UIFont+:  Failed to register font - font could not be loaded.")
            return
        }

        var errorRef: Unmanaged<CFError>? = nil
        if (CTFontManagerRegisterGraphicsFont(font, &errorRef) == false) {
            print("UIFont+:  Failed to register font - register graphics font failed - this font may have already been registered in the main bundle.")
        }
    }

}
