//
//  NSAttributedTextExtension.swift
//  Shopiroller
//
//  Created by Görkem Gür on 8.06.2022.
//

import Foundation

extension NSAttributedString {
    convenience init(format: NSAttributedString, args: NSAttributedString...) {
        let mutableNSAttributedString = NSMutableAttributedString(attributedString: format)

        args.forEach { (arguments) in
            let range = NSString(string: mutableNSAttributedString.string).range(of: "%@")
            mutableNSAttributedString.replaceCharacters(in: range, with: arguments)
        }
        self.init(attributedString: mutableNSAttributedString)
    }
}
