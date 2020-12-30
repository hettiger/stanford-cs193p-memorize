//
//  MemoryGame+Card.swift
//  Memorize
//
//  Created by Martin Hettiger on 27.12.20.
//

import Foundation

extension MemoryGame {
    struct Card: Identifiable, Hashable {
        let id: Int
        let content: ContentType

        var isFaceUp = false
    }
}
