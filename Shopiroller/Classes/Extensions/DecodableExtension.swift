//
//  SREnumDecodable.swift
//  shopiroller
//
//  Created by Görkem Gür on 16.09.2021.
//

protocol EnumDecodable: RawRepresentable, Decodable {
    static var `default`: Self { get }
}

extension EnumDecodable where RawValue: Decodable {
    
    internal init(from decoder: Decoder) throws {
        let value = try decoder.singleValueContainer().decode(RawValue.self)
        self = Self(rawValue: value) ?? Self.`default`
    }
    
}
