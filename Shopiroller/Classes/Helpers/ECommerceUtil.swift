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
        dateFormatterPrint.dateFormat = toFormat
        
        return dateFormatterPrint.string(from: date ?? Date())
    }
    
    static func getCurrencySymbol(currency: String?) -> String {
        guard let currency = currency else {return ""}
        if (currency.caseInsensitiveCompare("TRY") == .orderedSame){return "₺"}
        else if (currency.caseInsensitiveCompare("EUR") == .orderedSame){return "€"}
        else if (currency.caseInsensitiveCompare("USD") == .orderedSame){return "$"}
        else if (currency.caseInsensitiveCompare("GBP") == .orderedSame){return "£"}
        else if (currency.caseInsensitiveCompare("IRR") == .orderedSame){return "﷼"}
        else if (currency.caseInsensitiveCompare("NOK") == .orderedSame){return "kr"}
        else if (currency.caseInsensitiveCompare("RUB") == .orderedSame){return "\u{20BD}"}
        return currency
    }
    
    static func getFormattedPrice(price: Double?, currency: String?) -> String {
        guard let price = price, let currency = currency else { return "" }
        return String(format: "%.2f", price) + " " + currency
    }
    
   static func getBoldNormal(_ bold: String, _ normal: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: bold, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 12)])
        attributedString.append(NSMutableAttributedString(string: normal, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12, weight: .regular)]))
        return attributedString
    }
}
