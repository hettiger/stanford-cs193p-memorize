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
        registerEmojiMemoryGame(container)
        registerEmojiMemoryGameThemeChooser(container)

        return container
    }

    private static func registerThemes(_ container: Container) {
        container.register([Game.Theme].self) { _ in
            [
                .init(
                    name: "Animals",
                    contents: "🦆🦅🦉🐺🐗🐴🐝🪱🐛🦋",
                    color: .orange
                ),
                .init(
                    name: "Food",
                    contents: "🍎🍋🍉🍇🍓🍌🍒🥝🌽🧅",
                    color: .red
                ),
                .init(
                    name: "Activities",
                    contents: "⚽️🏀🏈🎾🎱🏓⛳️🛼🥋🪁",
                    color: .green
                ),
                .init(
                    name: "Tech",
                    contents: "⌚️💻📱🖥🖨📷☎️📡🔦📺",
                    color: .gray
                ),
                .init(
                    name: "Travel",
                    contents: "🚙🚌🚕🚑🚓🚒🚜🚃🚂✈️",
                    color: .blue
                ),
                .init(
                    name: "Countries",
                    contents: "🇺🇸🇩🇪🇫🇷🇱🇺🇵🇱🇨🇭🇩🇰🇦🇹🇨🇿🇮🇹",
                    color: .purple
                ),
            ]
        }
    }

    private static func registerGame(_ container: Container) {
        container.autoregister(
            Game.self,
            argument: Game.Theme.self,
            initializer: Game.init(theme:userDefaults:randomSource:)
        )
    }

    private static func registerEmojiMemoryGame(_ container: Container) {
        container.autoregister(
            EmojiMemoryGame.self,
            initializer: EmojiMemoryGame.init(themeStore:randomSource:)
        ).inObjectScope(.container)
    }

    private static func registerEmojiMemoryGameThemeChooser(_ container: Container) {
        container.autoregister(
            EmojiMemoryGameThemeStore.self,
            initializer: EmojiMemoryGameThemeStore.init
        )
    }
}
