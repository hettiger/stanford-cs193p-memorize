//
//  MemoryGame.swift
//  Memorize
//
//  Created by Martin Hettiger on 27.12.20.
//

import Foundation
import GameKit

struct MemoryGame<ContentType> {
    var cards: [Card]

    init(
        numberOfPairsOfCards: Int,
        randomSource: GKRandomSource = .sharedRandom(),
        cardContentFactory: (Int) -> ContentType
    ) {
        cards = []
        for pairIndex in 0 ..< numberOfPairsOfCards {
            cards.append(Card(id: pairIndex * 2, content: cardContentFactory(pairIndex)))
            cards.append(Card(id: pairIndex * 2 + 1, content: cardContentFactory(pairIndex)))
        }
        cards.shuffle(using: randomSource)
    }

    mutating func choose(card: Card) {
        guard let index = cards.firstIndex(of: card) else { preconditionFailure() }
        cards[index].choose()
    }
}
