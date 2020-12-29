//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Martin Hettiger on 27.12.20.
//

import Foundation

class EmojiMemoryGame {
    static var shared = EmojiMemoryGame()

    lazy var randomSource = Container.shared.randomSource

    private lazy var game: MemoryGame<String> = {
        var emojis = Array("🐶🐱🐭🐰🦊🐻🐼🐻‍❄️🐨🐯🦁🐮🐷🐽🐸🐵🐔🐧").shuffled(using: randomSource)
        return MemoryGame<String>(numberOfPairsOfCards: .random(in: 2 ... 5, using: randomSource)) {
            "\(emojis[$0])"
        }
    }()

    // MARK: - Model Accessors

    var cards: [MemoryGame<String>.Card] {
        game.cards
    }

    // MARK: - Intents

    func choose(card: MemoryGame<String>.Card) {
        game.choose(card: card)
    }
}
