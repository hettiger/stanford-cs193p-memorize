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
            .init(name: "Animals", contents: "🦆🦅🦉🐺🐗🐴🐝🪱🐛🦋", color: .orange),
            .init(name: "Food", contents: "🍎🍋🍉🍇🍓🍌🍒🥝🌽🧅", color: .red),
            .init(name: "Activities", contents: "⚽️🏀🏈🎾🎱🏓⛳️🛼🥋🪁", color: .green),
            .init(name: "Tech", contents: "⌚️💻📱🖥🖨📷☎️📡🔦📺", numberOfCards: 6, color: .gray),
            .init(name: "Travel", contents: "🚙🚌🚕🚑🚓🚒🚜🚃🚂✈️", numberOfCards: 8, color: .blue),
            .init(name: "Countries", contents: "🇺🇸🇩🇪🇫🇷🇱🇺🇵🇱🇨🇭🇩🇰🇦🇹🇨🇿🇮🇹", color: .purple),
        ])
    }

    // MARK: - Model Accessors

    var theme: Game.Theme {
        game.theme
    }

    var cards: [Game.Card] {
        game.cards
    }

    var score: Int {
        game.score
    }

    var highscore: Int {
        game.highscore
    }

    // MARK: - Intents

    func choose(card: Game.Card) {
        game.choose(card: card)
    }

    func startFresh() {
        game.startFresh()
    }
}
