//
//  Character+Codable.swift
//  Memorize
//
//  Created by Martin Hettiger on 20.02.21.
//

import Foundation

extension Character: Codable {
    public init(from decoder: Decoder) throws {
        let value = try decoder.singleValueContainer().decode(String.self)
        self.init(value)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(String(self))
    }
}
