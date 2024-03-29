//
//  ECommerceUtil.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 21.10.2021.
//

import Foundation

class ECommerceUtil {
    
    public static let serverResponseDateFormat: String  = "yyyy-MM-dd'T'HH:mm:ss"
    public static let ddMMMMyyy: String  = "dd MMMM yyyy"
    public static let EEEEhhmm: String  = "EEEE, HH:mm"
    
    static func convertServerDate(date: String?, toFormat: String) -> String? {
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = serverResponseDateFormat
        
        let date = dateFormatterGet.date(from: date ?? "")
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.locale = Locale.preferredLocale()
        dateFormatterPrint.dateFormat = toFormat
        
        return dateFormatterPrint.string(from: date ?? Date())
    }
    
    static func getFormattedPrice(price: Double?, currency: String?) -> String {
        guard let price = price, let currency = currency else { return "" }
        let formatter = NumberFormatter()
        formatter.currencyCode = currency
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: price)) ?? ""
    }
    
    static func getStrikethroughPrice(price: Double?, currency: String?) -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: getFormattedPrice(price: price, currency: currency))
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
    
    static func getBoldNormal(_ bold: String, _ normal: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: bold, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 12)])
        attributedString.append(NSMutableAttributedString(string: normal, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12, weight: .regular)]))
        return attributedString
    }
    
    static func urlContainsOf(_ url: String, queryParamaterName: String) -> String? {
        guard let url = URLComponents(string: url) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParamaterName })?.value
    }
}
