//
//  String+Cards.swift
//  MemorizeTests
//
//  Created by Martin Hettiger on 30.12.20.
//

import Foundation
@testable import Memorize

extension String {
    var cards: [MemoryGame<Element>.Card] {
        let characters = Array(self)
        return characters.enumerated().map {
            MemoryGame<Element>.Card(id: $0.offset, content: $0.element)
        }
    }
}
