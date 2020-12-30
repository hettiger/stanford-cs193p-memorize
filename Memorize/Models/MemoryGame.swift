//
//  MemoryGame.swift
//  Memorize
//
//  Created by Martin Hettiger on 27.12.20.
//

import Foundation
import GameKit

struct MemoryGame<ContentType> where ContentType: Hashable {
    enum State: Equatable {
        case noCardFaceUp
        case oneCardFaceUp(Card.ID)
        case twoCardsFaceUp(Card.ID, Card.ID)
    }

    private(set) var state: State = .noCardFaceUp {
        didSet {
            print("current state: \(state)")
        }
    }

    private(set) var cards: [Card]

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
        print("choose card: \(card)")
        switch state {
        case .noCardFaceUp:
            cards[cards.firstIndex(of: card)!].isFaceUp = true
            state = .oneCardFaceUp(card.id)
        case let .oneCardFaceUp(id) where card.id != id:
            cards[cards.firstIndex(of: card)!].isFaceUp = true
            state = .twoCardsFaceUp(id, card.id)
        case let .twoCardsFaceUp(idA, idB)
            where card.id != idA && card.id != idB:
            for (i, c) in cards.enumerated() {
                cards[i].isFaceUp = card.id == c.id
            }
            state = .oneCardFaceUp(card.id)
        default:
            break
        }
    }
}
