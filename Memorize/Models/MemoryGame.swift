//
//  MemoryGame.swift
//  Memorize
//
//  Created by Martin Hettiger on 27.12.20.
//

import Foundation
import GameKit

struct MemoryGame<ContentType> {
    var randomSource: GKRandomSource = Container.shared.randomSource
    var cards: [Card]

    init(
        numberOfPairsOfCards: Int,
        cardContentFactory: (Int) -> ContentType
    ) {
        cards = []
        for pairIndex in 0 ..< numberOfPairsOfCards {
            cards.append(Card(id: pairIndex * 2, content: cardContentFactory(pairIndex)))
            cards.append(Card(id: pairIndex * 2 + 1, content: cardContentFactory(pairIndex)))
        }
        cards = randomSource.arrayByShufflingObjects(in: cards) as! [Card]
    }

    mutating func choose(card: Card) {
        guard let index = cards.firstIndex(where: { $0.id == card.id }) else {
            preconditionFailure()
        }

        cards[index].choose()
    }
}
