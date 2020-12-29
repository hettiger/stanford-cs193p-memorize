//
//  MemoryGame+Card.swift
//  Memorize
//
//  Created by Martin Hettiger on 27.12.20.
//

import Foundation

extension MemoryGame {
    struct Card: Identifiable {
        let id: Int
        let content: ContentType

        private(set) var isFaceUp = false

        mutating func choose() {
            isFaceUp.toggle()
            print("chose card: \(self)")
        }
    }
}

// MARK: - Hashable Card Implementation

extension MemoryGame.Card: Hashable {
    static func == (lhs: MemoryGame<ContentType>.Card, rhs: MemoryGame<ContentType>.Card) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
