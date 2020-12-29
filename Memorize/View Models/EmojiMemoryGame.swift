//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Martin Hettiger on 27.12.20.
//

import Foundation
import GameKit

class EmojiMemoryGame: ObservableObject {
    static var shared = EmojiMemoryGame()

    @Published
    private var game: MemoryGame<String>

    init(randomSource: GKRandomSource = Container.shared.randomSource) {
        let emojis = Array("🐶🐱🐭🐰🦊🐻🐼🐻‍❄️🐨🐯🦁🐮🐷🐽🐸🐵🐔🐧").shuffled(using: randomSource)
        game = MemoryGame<String>(numberOfPairsOfCards: .random(in: 2 ... 5, using: randomSource)) {
            "\(emojis[$0])"
        }
    }

    // MARK: - Model Accessors

    var cards: [MemoryGame<String>.Card] {
        game.cards
    }

    // MARK: - Intents

    func choose(card: MemoryGame<String>.Card) {
        game.choose(card: card)
    }
}
