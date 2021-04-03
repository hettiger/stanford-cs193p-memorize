//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Martin Hettiger on 27.12.20.
//

import Foundation

class EmojiMemoryGame: ObservableObject {
    typealias Game = MemoryGame<Character>
    typealias GameFactory = (_ currentGame: Game?) -> Game

    @Published
    private var game: Game

    private var makeGame: GameFactory

    init(initialTheme: Game.Theme, gameFactory: @escaping GameFactory) {
        theme = initialTheme
        makeGame = gameFactory
        game = makeGame(nil)
        $game.map(\.theme).assign(to: &$theme)
        startFresh(theme: initialTheme)
    }

    // MARK: - Model Accessors

    @Published
    private(set) var theme: Game.Theme

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

    func startFresh(theme: Game.Theme? = nil) {
        if let theme = theme {
            game = MemorizeApp.container.resolve(Game.self, argument: theme)!
        } else {
            game = makeGame(game)
        }
    }
}
