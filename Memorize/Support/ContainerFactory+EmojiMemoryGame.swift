//
//  ContainerFactory+EmojiMemoryGame.swift
//  Memorize
//
//  Created by Martin Hettiger on 08.03.21.
//

import Foundation
import Swinject
import SwinjectAutoregistration

extension ContainerFactory {
    private typealias Game = EmojiMemoryGame.Game

    static func makeEmojiMemoryGameContainer() -> Container {
        let container = Container(parent: makeMemorizeAppContainer())

        registerThemes(container)
        registerGame(container)
        registerGameFactory(container)
        registerEmojiMemoryGame(container)
        registerEmojiMemoryGameThemeChooser(container)

        return container
    }

    private static func registerThemes(_ container: Container) {
        container.register([Game.Theme].self) { resolver in
            let randomSource = resolver.resolve(RandomSource.self)
            return [
                .init(
                    name: "Animals",
                    contents: "🦆🦅🦉🐺🐗🐴🐝🪱🐛🦋",
                    numberOfPairsOfCards: 5,
                    color: .orange,
                    randomSource: randomSource
                ),
                .init(
                    name: "Food",
                    contents: "🍎🍋🍉🍇🍓🍌🍒🥝🌽🧅",
                    numberOfPairsOfCards: 6,
                    color: .red,
                    randomSource: randomSource
                ),
                .init(
                    name: "Activities",
                    contents: "⚽️🏀🏈🎾🎱🏓⛳️🛼🥋🪁",
                    numberOfPairsOfCards: 7,
                    color: .green,
                    randomSource: randomSource
                ),
                .init(
                    name: "Tech",
                    contents: "⌚️💻📱🖥🖨📷☎️📡🔦📺",
                    numberOfPairsOfCards: 3,
                    color: .gray,
                    randomSource: randomSource
                ),
                .init(
                    name: "Travel",
                    contents: "🚙🚌🚕🚑🚓🚒🚜🚃🚂✈️",
                    numberOfPairsOfCards: 4,
                    color: .blue,
                    randomSource: randomSource
                ),
                .init(
                    name: "Countries",
                    contents: "🇺🇸🇩🇪🇫🇷🇱🇺🇵🇱🇨🇭🇩🇰🇦🇹🇨🇿🇮🇹",
                    numberOfPairsOfCards: 3,
                    color: .purple,
                    randomSource: randomSource
                ),
            ]
        }
    }

    private static func registerGame(_ container: Container) {
        container.autoregister(
            Game.self,
            argument: Game.Theme.self,
            initializer: Game.init(theme:userDefaults:)
        )
    }

    private static func registerGameFactory(_ container: Container) {
        container.register(EmojiMemoryGame.GameFactory.self) { resolver in
            { currentGame in
                let themes = resolver.resolve([Game.Theme].self)!
                let randomSource = resolver.resolve(RandomSource.self)!
                let theme = themes
                    .filter { $0.name != currentGame?.theme.name ?? "" }
                    .shuffled(using: randomSource)
                    .first
                    ?? themes[0]
                return resolver.resolve(Game.self, argument: theme)!
            }
        }
    }

    private static func registerEmojiMemoryGame(_ container: Container) {
        container
            .register(EmojiMemoryGame.self) { (resolver: Resolver, theme: Game.Theme) in
                resolver.resolve(EmojiMemoryGame.self, argument: { (_: Game?) -> Game in
                    resolver.resolve(Game.self, argument: theme)!
                })!
            }

        container.autoregister(
            EmojiMemoryGame.self,
            argument: EmojiMemoryGame.GameFactory.self,
            initializer: EmojiMemoryGame.init(gameFactory:)
        )

        container.autoregister(
            EmojiMemoryGame.self,
            initializer: EmojiMemoryGame.init(gameFactory:)
        ).inObjectScope(.container)
    }

    private static func registerEmojiMemoryGameThemeChooser(_ container: Container) {
        container.autoregister(
            EmojiMemoryGameThemeStore.self,
            initializer: EmojiMemoryGameThemeStore.init
        )
    }
}
