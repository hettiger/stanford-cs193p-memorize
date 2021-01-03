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
    static var randomSource: RandomSource = GKRandomSource.sharedRandom()

    private static var themes: [Game.Theme] {
        [
            .init(name: "Animals", contents: "🦆🦅🦉🐺🐗🐴🐝🪱🐛🦋", color: .orange),
            .init(name: "Food", contents: "🍎🍋🍉🍇🍓🍌🍒🥝🌽🧅", color: .red),
            .init(name: "Activities", contents: "⚽️🏀🏈🎾🎱🏓⛳️🛼🥋🪁", color: .green),
            .init(name: "Tech", contents: "⌚️💻📱🖥🖨📷☎️📡🔦📺", numberOfCards: 6, color: .gray),
            .init(name: "Travel", contents: "🚙🚌🚕🚑🚓🚒🚜🚃🚂✈️", numberOfCards: 8, color: .blue),
            .init(name: "Countries", contents: "🇺🇸🇩🇪🇫🇷🇱🇺🇵🇱🇨🇭🇩🇰🇦🇹🇨🇿🇮🇹", color: .purple),
        ]
    }

    private static func makeGame(isIncluded: ((Game.Theme) -> Bool) = { _ in true }) -> Game {
        Game(theme: themes.filter(isIncluded).shuffled(using: randomSource).first ?? themes[0])
    }

    @Published
    private var game = EmojiMemoryGame.makeGame()

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
        game = EmojiMemoryGame.makeGame { $0.name != game.theme.name }
    }
}
