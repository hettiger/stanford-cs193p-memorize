//
//  Color+Codable.swift
//  Memorize
//
//  Created by Martin Hettiger on 20.02.21.
//

import SwiftUI

extension Color: Codable {
    enum CodingKeys: String, CodingKey {
        case r, g, b, a
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let r: CGFloat = try values.decode(CGFloat.self, forKey: .r)
        let g: CGFloat = try values.decode(CGFloat.self, forKey: .g)
        let b: CGFloat = try values.decode(CGFloat.self, forKey: .b)
        let a: CGFloat = try values.decode(CGFloat.self, forKey: .a)
        let uiColor = UIColor(red: r, green: g, blue: b, alpha: a)
        self.init(uiColor)
    }

    public func encode(to encoder: Encoder) throws {
        let uiColor = UIColor(self)
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        uiColor.getRed(&r, green: &g, blue: &b, alpha: &a)
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(r, forKey: .r)
        try container.encode(g, forKey: .g)
        try container.encode(b, forKey: .b)
        try container.encode(a, forKey: .a)
    }
}
