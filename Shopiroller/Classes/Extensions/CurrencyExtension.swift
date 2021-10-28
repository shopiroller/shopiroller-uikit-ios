//
//  CurrencyExtension.swift
//  Shopiroller
//
//  Created by Görkem Gür on 13.10.2021.
//

import Foundation

extension String {
    
    func makeShippingPriceBold(_ currency: String? ) -> NSMutableAttributedString {
              
        let mutableAttrString = NSMutableAttributedString(string: self)
        
        mutableAttrString.appendSpace()
        
        mutableAttrString.append(NSMutableAttributedString(string: currency ?? ""))
        
        let firstIndex = firstIndex(of: "#")?.utf16Offset(in: self) ?? 0
        
        let lastIndex = lastIndex(of: "#")?.utf16Offset(in: self) ?? 0
        
        let range = NSRange(location: firstIndex - 1, length: lastIndex - firstIndex + 5)

        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 10)]
        
        mutableAttrString.addAttributes(attrs, range: range)

        return mutableAttrString
    }
    
    func makeStrokeCurrency(_ price: String , currency: String) -> NSMutableAttributedString {
        let attributedString: NSMutableAttributedString =  NSMutableAttributedString(string: price)
        
        attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributedString.length))
        
        attributedString.appendSpace()
        
        attributedString.append(NSMutableAttributedString(string: currency))
        
        return attributedString
    }
    
}
