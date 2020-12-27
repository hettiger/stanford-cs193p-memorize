//
//  MemoryGame.swift
//  Memorize
//
//  Created by Martin Hettiger on 27.12.20.
//

import Foundation

struct MemoryGame<ContentType> {
    var cards: [Card]

    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> ContentType) {
        cards = []
        for pairIndex in 0 ..< numberOfPairsOfCards {
            cards.append(Card(id: pairIndex * 2, content: cardContentFactory(pairIndex)))
            cards.append(Card(id: pairIndex * 2 + 1, content: cardContentFactory(pairIndex)))
        }
    }

    struct Card: Identifiable {
        let id: Int
        let content: ContentType

        private(set) var isFaceUp = false

        mutating func choose() {
            isFaceUp.toggle()
        }
    }
}
