//
//  CurrencyExtension.swift
//  Shopiroller
//
//  Created by Görkem Gür on 13.10.2021.
//

import Foundation

extension String {
    
    func makeStrokeCurrency(currency: String) -> NSMutableAttributedString {
        let attributedString: NSMutableAttributedString =  NSMutableAttributedString(string: self)
        
        attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributedString.length))
        
        attributedString.appendSpace()
        
        attributedString.append(NSMutableAttributedString(string: currency))
        
        return attributedString
    }
    
}
