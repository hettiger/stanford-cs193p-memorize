//
//  MemoryGame.swift
//  Memorize
//
//  Created by Martin Hettiger on 27.12.20.
//

import Foundation
import GameKit

struct MemoryGame<ContentType: Hashable> {
    private var randomSource: GKRandomSource?

    private(set) var themes: [Theme] {
        willSet {
            guard newValue.count > 0
            else { preconditionFailure("a game requires at least one theme") }
        }
        didSet {
            restart()
        }
    }

    private(set) var theme: Theme {
        didSet {
            state = .noCardFaceUp
            cards = theme.cards
            score = initialScore
            print("current theme: \(theme.name)")
        }
    }

    private(set) var state: State = .noCardFaceUp {
        didSet {
            print("current state: \(state)")
        }
    }

    private(set) var cards = [Card]()
    
    private(set) var score = 0

    init(themes: [Theme], randomSource: GKRandomSource? = .sharedRandom()) {
        self.randomSource = randomSource
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
                score += matchScore
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

    mutating func restart() {
        if themes.count > 1, let randomSource = randomSource {
            theme = themes.filter { $0 != theme }.shuffled(using: randomSource)[0]
        } else {
            theme = themes[0]
        }
    }
    
    // MARK: - Score Constants
    
    let initialScore = 0
    let matchScore = 2
}
