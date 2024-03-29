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
    
    static let regular8: UIFont = SRFont.regular.font(ofSize: 8.0)
        
    static let regular10: UIFont = SRFont.regular.font(ofSize: 10.0)
    
    static let regular12: UIFont = SRFont.regular.font(ofSize: 12.0)
    
    static let regular14: UIFont = SRFont.regular.font(ofSize: 14.0)
    
    static let regular24: UIFont = SRFont.regular.font(ofSize: 24.0)
    
    static let medium12: UIFont = SRFont.medium.font(ofSize: 12.0)
    
    static let medium13: UIFont = SRFont.medium.font(ofSize: 13.0)
    
    static let medium14: UIFont = SRFont.medium.font(ofSize: 14.0)
    
    static let medium20: UIFont = SRFont.medium.font(ofSize: 20.0)
    
    static let semiBold10: UIFont = SRFont.semiBold.font(ofSize: 10.0)
        
    static let semiBold12: UIFont = SRFont.semiBold.font(ofSize: 12.0)
    
    static let semiBold13: UIFont = SRFont.semiBold.font(ofSize: 13.0)
    
    static let semiBold14: UIFont = SRFont.semiBold.font(ofSize: 14.0)
    
    static let semiBold15: UIFont = SRFont.semiBold.font(ofSize: 15.0)
    
    static let semiBold16: UIFont = SRFont.semiBold.font(ofSize: 16.0)
    
    static let semiBold20: UIFont = SRFont.semiBold.font(ofSize: 20.0)
        
    static let bold24: UIFont = SRFont.bold.font(ofSize: 24)
    
    static let bold18: UIFont = SRFont.bold.font(ofSize: 18)
    
    static let bold9: UIFont = SRFont.bold.font(ofSize: 9)
    
    static let bold10: UIFont = SRFont.bold.font(ofSize: 10)
    
    static let bold13: UIFont = SRFont.bold.font(ofSize: 13)
    
    static let bold14: UIFont = SRFont.bold.font(ofSize: 14)


    
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
