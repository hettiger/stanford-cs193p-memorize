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
    static var randomSource: RandomSource = MersenneTwisterRandomSource.shared

    static var themes: [Game.Theme] {
        [
            .init(name: "Animals", contents: "🦆🦅🦉🐺🐗🐴🐝🪱🐛🦋", numberOfPairsOfCards: 5, color: .orange),
            .init(name: "Food", contents: "🍎🍋🍉🍇🍓🍌🍒🥝🌽🧅", numberOfPairsOfCards: 6, color: .red),
            .init(
                name: "Activities",
                contents: "⚽️🏀🏈🎾🎱🏓⛳️🛼🥋🪁",
                numberOfPairsOfCards: 7,
                color: .green
            ),
            .init(name: "Tech", contents: "⌚️💻📱🖥🖨📷☎️📡🔦📺", numberOfPairsOfCards: 3, color: .gray),
            .init(name: "Travel", contents: "🚙🚌🚕🚑🚓🚒🚜🚃🚂✈️", numberOfPairsOfCards: 4, color: .blue),
            .init(
                name: "Countries",
                contents: "🇺🇸🇩🇪🇫🇷🇱🇺🇵🇱🇨🇭🇩🇰🇦🇹🇨🇿🇮🇹",
                numberOfPairsOfCards: 3,
                color: .purple
            ),
        ]
    }

    private static func makeGame(isIncluded: ((Game.Theme) -> Bool) = { _ in true }) -> Game {
        Game(theme: themes.filter(isIncluded).shuffled(using: randomSource).first ?? themes[0])
    }

    @Published
    private var game = EmojiMemoryGame.makeGame()

    // MARK: - Model Accessors

    var theme: Game.Theme {
        get { game.theme }
        set { game = .init(theme: newValue) }
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
