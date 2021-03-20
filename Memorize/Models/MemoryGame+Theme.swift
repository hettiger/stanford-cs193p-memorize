//
//  MemoryGame+Theme.swift
//  Memorize
//
//  Created by Martin Hettiger on 01.01.21.
//

import GameKit
import SwiftUI

extension MemoryGame {
    struct Theme: Hashable, Codable, Identifiable {
        let name: String
        let contents: Set<ContentType>
        let color: Color

        private(set) var id = UUID()

        init<T: Sequence>(name: String, contents: T, color: Color = .clear)
            where T.Element == ContentType
        {
            self.name = name
            self.contents = Set(contents)
            self.color = color
        }
    }
}
