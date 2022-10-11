//
//  NSMutableAttributedStringExtension.swift
//  Shopiroller
//
//  Created by Emre Can Altaca on on 13.10.2021.
//

import Foundation

extension NSMutableAttributedString {
    
    func appendSpace() {
        append(NSAttributedString(string: " "))
    }
    
    
    func stringWithString(stringToReplace: String, replacedWithString newStringPart: String) -> NSMutableAttributedString
    {
        let mutableAttributedString = mutableCopy() as? NSMutableAttributedString
        if let mutableString = mutableAttributedString?.mutableString {
            while mutableString.contains(stringToReplace) {
                let rangeOfStringToBeReplaced = mutableString.range(of: stringToReplace)
                mutableAttributedString?.replaceCharacters(in: rangeOfStringToBeReplaced, with: newStringPart)
            }
        }
        return mutableAttributedString ?? NSMutableAttributedString()
    }
}
