//
//  MemoryGame.swift
//  Memorize
//
//  Created by Martin Hettiger on 27.12.20.
//

import Foundation
import GameKit

struct MemoryGame<ContentType> where ContentType: Hashable, ContentType: Codable {
    typealias ContentType = ContentType

    enum State: Hashable {
        case noCardFaceUp
        case oneCardFaceUp(Card)
        case twoCardsFaceUp(Card, Card)
    }

    let theme: Theme
    let userDefaults: UserDefaults
    let randomSource: RandomSource

    private(set) var state: State = .noCardFaceUp {
        didSet {
            updateScore()
            print("current state: \(state)")
        }
    }

    private(set) var cards = [Card]()

    private(set) var score: Int {
        didSet {
            highscore = max(highscore, score)
        }
    }

    private(set) var highscore: Int {
        get { userDefaults.integer(forKey: UserDefaults.Key.highscore.rawValue) }
        set { userDefaults.set(newValue, forKey: UserDefaults.Key.highscore.rawValue) }
    }

    init(
        theme: Theme,
        userDefaults: UserDefaults,
        randomSource: RandomSource
    ) {
        self.theme = theme
        self.userDefaults = userDefaults
        self.randomSource = randomSource
        cards = self.theme.contents.reduce(into: [Card]()) { cards, content in
            for _ in 1 ... 2 { cards.append(Card(id: cards.count, content: content)) }
        }.shuffled(using: randomSource)
        score = initialScore
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
            markMatchedCards(cards[indexA], cards[indexB])
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

    private mutating func markMatchedCards(_ cardA: Card, _ cardB: Card) {
        guard cardA.content == cardB.content else { return }
        let indexA = cards.firstIndex(of: cardA)!
        let indexB = cards.firstIndex(of: cardB)!
        cards[indexA].isMatched = true
        cards[indexB].isMatched = true
    }

    private mutating func updateScore() {
        switch state {
        case let .twoCardsFaceUp(cardA, cardB):
            for card in [cardA, cardB] {
                let index = cards.firstIndex(of: card)!
                if cards[index].hasEarnedBonus {
                    score += isMatchedScore
                } else if cards[index].hasBeenFaceUp {
                    score += hasBeenFaceUpScore
                }
            }
        default:
            break
        }
    }

    // MARK: - Score Constants

    private let initialScore = 0
    private let isMatchedScore = 1
    private let hasBeenFaceUpScore = -1
}
