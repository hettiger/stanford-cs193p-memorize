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
    private var userDefaults: UserDefaults

    private(set) var themes: [Theme] {
        willSet {
            guard newValue.count > 0
            else { preconditionFailure("a game requires at least one theme") }
        }
        didSet {
            startFresh()
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
            updateScore()
            print("current state: \(state)")
        }
    }

    private(set) var cards = [Card]()

    private(set) var score = 0 {
        didSet {
            highscore = max(highscore, score)
        }
    }

    var highscore: Int {
        get { userDefaults.integer(forKey: UserDefaults.Key.highscore.rawValue) }
        set { userDefaults.set(newValue, forKey: UserDefaults.Key.highscore.rawValue) }
    }

    init(
        themes: [Theme],
        randomSource: GKRandomSource? = .sharedRandom(),
        userDefaults: UserDefaults = .standard
    ) {
        self.randomSource = randomSource
        self.userDefaults = userDefaults
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
            let minChosenAt = min(cardA.chosenAt!, cardB.chosenAt!)
            guard minChosenAt.addingTimeInterval(maxAllowedSecondsToMatch) > Date.current
            else { break }
            for card in [cardA, cardB] {
                let index = cards.firstIndex(of: card)!
                if cards[index].isMatched {
                    score += isMatchedScore
                } else if cards[index].hasBeenFaceUp {
                    score += hasBeenFaceUpScore
                }
            }
        default:
            break
        }
    }

    mutating func startFresh() {
        if themes.count > 1, let randomSource = randomSource {
            theme = themes.filter { $0 != theme }.shuffled(using: randomSource)[0]
        } else {
            theme = themes[0]
        }
    }

    // MARK: - Score Constants

    let initialScore = 0
    let isMatchedScore = 1
    let hasBeenFaceUpScore = -1
    let maxAllowedSecondsToMatch = 3.0
}
