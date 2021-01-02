//
//  MemoryGame.swift
//  Memorize
//
//  Created by Martin Hettiger on 27.12.20.
//

import Foundation
import GameKit

struct MemoryGame<ContentType: Hashable> {
    private(set) var themes: [Theme] {
        willSet {
            guard newValue.count > 0
            else { preconditionFailure("a game requires at least one theme") }
        }
        didSet {
            theme = themes[0]
        }
    }

    var theme: Theme {
        didSet {
            state = .noCardFaceUp
            cards = theme.cards
            print("current theme: \(theme.name)")
        }
    }

    private(set) var state: State = .noCardFaceUp {
        didSet {
            print("current state: \(state)")
        }
    }

    private(set) var cards = [Card]()

    init(themes: [Theme]) {
        self.themes = [.init(name: "Empty", contents: [])]
        theme = self.themes[0]
        defer { if !themes.isEmpty { self.themes = themes } }
    }

    mutating func choose(card: Card) {
        guard !card.isMatched else { return }
        print("chosen card: \(card)")
        switch state {
        case .noCardFaceUp:
            cards[cards.firstIndex(of: card)!].isFaceUp = true
            state = .oneCardFaceUp(card.id)
        case let .oneCardFaceUp(id) where card.id != id:
            let cardIndex = cards.firstIndex(of: card)!
            cards[cardIndex].isFaceUp = true
            state = .twoCardsFaceUp(id, card.id)
            if state.showsMatch(in: cards) {
                cards[cards.firstIndex(with: id)!].isMatched = true
                cards[cardIndex].isMatched = true
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
