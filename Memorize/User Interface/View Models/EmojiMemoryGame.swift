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

    init(gameFactory: @escaping GameFactory) {
        makeGame = gameFactory
        themeObserver = MemorizeApp.container.resolve([Game.Theme].self)![0]
        game = makeGame(nil)
        $game.map(\.theme).assign(to: &$themeObserver)
    }

    // MARK: - Model Accessors

    @Published
    var themeObserver: Game.Theme

    var theme: Game.Theme {
        get { game.theme }
        set { game = MemorizeApp.container.resolve(Game.self, argument: newValue)! }
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
        game = makeGame(game)
    }
}
