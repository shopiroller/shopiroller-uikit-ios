//
//  StringExtensions.swift
//  shopiroller
//
//  Created by Görkem Gür on 19.09.2021.
//

import UIKit


extension String {
    
    public static let NEW_LINE = "\n"
    
    var length: Int {
        return count
    }
    
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }
    
    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    
    func calculateDiscount(price: Double , campaignPrice: Double) -> String {
        let discount = price - campaignPrice
        let percentage = (discount / price) * 100
        let discountedPercenteage = String(format: "%.0f", percentage)
        return "%\(discountedPercenteage)"
    }
    
    func makeBoldString(boldText: String? , normalText: String?,isReverse: Bool = false) -> NSMutableAttributedString {
        
        let firstText = NSMutableAttributedString.init(string: boldText ?? "")
        firstText.setAttributes([NSAttributedString.Key.font: isReverse ? UIFont.semiBold10 : UIFont.boldSystemFont(ofSize: 12),
                                 NSAttributedString.Key.foregroundColor: isReverse ? UIColor.textSecondary : UIColor.textPCaption], range: NSMakeRange(0, firstText.length))
        let secondText = NSMutableAttributedString.init(string: normalText ?? "")
        secondText.setAttributes([NSAttributedString.Key.font: isReverse ? UIFont.regular10 : UIFont.systemFont(ofSize: 12),
                                  NSAttributedString.Key.foregroundColor: isReverse ? UIColor.textSecondary :
                                    UIColor.textPCaption], range: NSMakeRange(0, secondText.length))
        
        let finalText = NSMutableAttributedString()
        
        finalText.append(isReverse ? secondText : firstText)
        finalText.append(isReverse ? firstText : secondText)
        
        return finalText
    }
    
    var creditCardBrand: UIImage? {
        let numberOnly = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        for card in CardType.allCards {
            if (matchesRegex(regex: card.regex, text: numberOnly)) {
                return card.image
            }
        }
        
        return nil
    }
    
    func matchesRegex(regex: String!, text: String!) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [.caseInsensitive])
            let nsString = text as NSString
            let match = regex.firstMatch(in: text, options: [], range: NSMakeRange(0, nsString.length))
            return (match != nil)
        } catch {
            return false
        }
    }
    
    var isValidFullName: Bool {
        return 1...50 ~= count && rangeOfCharacter(from: CharacterSet.fullname.inverted) == nil
    }
    
    var isValidIban: Bool {
        return 1...50 ~= count && rangeOfCharacter(from: CharacterSet.fullname.inverted) == nil
    }
    
    var isValidCreditCardNumber: Bool {
        return 12...19 ~= count && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
    
    var isValidCreditCardCvv: Bool {
        return count == 3 && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
    
    func convertHtml() -> NSAttributedString{
        guard let data = data(using: String.Encoding.utf8) else { return NSAttributedString() }
        var attributedString: NSAttributedString = NSAttributedString()
        do {
            attributedString = try NSAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType:NSAttributedString.DocumentType.html,NSAttributedString.DocumentReadingOptionKey.characterEncoding:NSNumber(value: String.Encoding.utf8.rawValue)], documentAttributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
        } catch {
            print("error")
        }
        return attributedString
    }
}

