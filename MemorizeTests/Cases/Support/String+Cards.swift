//
//  String+Cards.swift
//  MemorizeTests
//
//  Created by Martin Hettiger on 30.12.20.
//

import Foundation
@testable import Memorize

extension String {
    var cards: [MemoryGame<String>.Card] {
        let characters = Array(self)
        return characters.enumerated().map {
            MemoryGame<String>.Card(id: $0.offset, content: String($0.element))
        }
    }
}
