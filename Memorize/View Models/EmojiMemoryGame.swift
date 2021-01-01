//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Martin Hettiger on 27.12.20.
//

import Foundation
import GameKit

class EmojiMemoryGame: ObservableObject {
    typealias Game = MemoryGame<Character>

    static var shared = EmojiMemoryGame()

    @Published
    private var game: Game

    init() {
        game = Game(themes: [
            .init(name: "Animals", contents: "🦆🦅🦉🐺🐗🐴🐝🪱🐛🦋🐌", color: .orange),
        ])
    }

    // MARK: - Model Accessors

    var cards: [Game.Card] {
        game.cards
    }

    // MARK: - Intents

    func choose(card: Game.Card) {
        game.choose(card: card)
    }
}
