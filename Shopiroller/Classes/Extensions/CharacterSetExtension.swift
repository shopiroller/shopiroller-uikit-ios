//
//  CharacterSetExtension.swift
//  Shopiroller
//
//  Created by Görkem Gür on 15.11.2021.
//

import Foundation

extension CharacterSet {
    
    static var fullname: CharacterSet {
//        return CharacterSet.letters.union(CharacterSet(charactersIn: " -'"))

        var allowedCharacterSet = CharacterSet.letters
        allowedCharacterSet.formUnion(.whitespaces)
        allowedCharacterSet.insert(charactersIn: "-")
//        allowedCharacterSet.insert(charactersIn: "'")
        allowedCharacterSet.insert(charactersIn: "\'")
//        let specialCharacterSet = CharacterSet(charactersIn: "-'")
//        allowedCharacterSet.formUnion(specialCharacterSet)
//        allowedCharacterSet.insert(charactersIn: "\u{0027}")
//        allowedCharacterSet.insert(charactersIn: "\u{00B4}")

        return allowedCharacterSet
    }
    
    static var phoneNumber: CharacterSet {
        return CharacterSet(charactersIn: "1234567890+ ")
    }
    
}
