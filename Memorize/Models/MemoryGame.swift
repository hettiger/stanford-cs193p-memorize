//
//  MemoryGame.swift
//  Memorize
//
//  Created by Martin Hettiger on 27.12.20.
//

import Foundation
import GameKit

struct MemoryGame<ContentType> where ContentType: Hashable {
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
        guard !card.isMatched else { return }
        print("choose card: \(card)")
        switch state {
        case .noCardFaceUp:
            cards[cards.firstIndex(of: card)!].isFaceUp = true
            state = .oneCardFaceUp(card.id)
        case let .oneCardFaceUp(id) where card.id != id:
            let index = cards.firstIndex(of: card)!
            cards[index].isFaceUp = true
            state = .twoCardsFaceUp(id, card.id)
            if state.showsMatch(in: cards) {
                cards[cards.firstIndex { id == $0.id }!].isMatched = true
                cards[index].isMatched = true
            }
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
