//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Martin Hettiger on 27.12.20.
//

import Foundation

class EmojiMemoryGame: ObservableObject {
    typealias Game = MemoryGame<Character>

    @Published
    private var game: Game

    private let themeStore: EmojiMemoryGameThemeStore

    private let randomSource: RandomSource

    init(themeStore: EmojiMemoryGameThemeStore, randomSource: RandomSource) {
        let theme = themeStore.themes.first!
        self.themeStore = themeStore
        self.randomSource = randomSource
        self.theme = theme
        game = MemorizeApp.container.resolve(Game.self, argument: theme)!
        $game.map(\.theme).assign(to: &$theme)
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
        let nextTheme = theme ??
            (themeStore.themes
                .filter { $0.name != game.theme.name }
                .shuffled(using: randomSource)
                .first ??
                themeStore.themes[0])

        game = MemorizeApp.container.resolve(Game.self, argument: nextTheme)!
    }
}
