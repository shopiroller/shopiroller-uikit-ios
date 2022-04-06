//
//  LocaleExtension.swift
//  Shopiroller
//
//  Created by Görkem Gür on 6.04.2022.
//

import Foundation

extension Locale {
    static func preferredLocale() -> Locale {
        guard let preferredIdentifier = Locale.preferredLanguages.first else {
            return Locale.current
        }
        return Locale(identifier: preferredIdentifier)
    }
}
