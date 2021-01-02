//
//  MemoryGame.swift
//  Memorize
//
//  Created by Martin Hettiger on 27.12.20.
//

import Foundation
import GameKit

struct MemoryGame<ContentType: Hashable> {
    enum State: Hashable {
        case noCardFaceUp
        case oneCardFaceUp(Card)
        case twoCardsFaceUp(Card, Card)
    }

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
            let index = cards.firstIndex(of: card)!
            cards[index].isFaceUp = true
            state = .oneCardFaceUp(cards[index])
        case let .oneCardFaceUp(cardA) where card != cardA:
            let indexA = cards.firstIndex(of: cardA)!
            let indexB = cards.firstIndex(of: card)!
            cards[indexB].isFaceUp = true
            if cardContentsMatch(lhs: cards[indexA], rhs: cards[indexB]) {
                cards[indexA].isMatched = true
                cards[indexB].isMatched = true
                score += matchScore
            } else {
                if cards[indexA].hasBeenFaceUp {
                    score -= 1
                }
                if cards[indexB].hasBeenFaceUp {
                    score -= 1
                }
            }
            state = .twoCardsFaceUp(cards[indexA], cards[indexB])
        case let .twoCardsFaceUp(cardA, cardB)
            where card != cardA && card != cardB:
            let index = cards.firstIndex(of: card)!
            for (i, c) in cards.enumerated() {
                cards[i].isFaceUp = c == card
            }
            state = .oneCardFaceUp(cards[index])
        default:
            break
        }
    }

    private func cardContentsMatch(lhs: Card, rhs: Card) -> Bool {
        lhs.content == rhs.content
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
