//
//  EmojiMemoryGameThemeStore.swift
//  Memorize
//
//  Created by Martin Hettiger on 09.03.21.
//

import Combine
import Foundation

class EmojiMemoryGameThemeStore: ObservableObject {
    typealias Game = EmojiMemoryGame.Game

    private let userDefaults: UserDefaults

    @Published
    var themes = [Game.Theme]()

    private var subscriptions = [AnyCancellable]()

    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults

        fetchThemes()
        autosaveThemes()
    }

    private func fetchThemes() {
        guard
            let json = userDefaults.string(forKey: UserDefaults.Key.themes.rawValue),
            let data = json.data(using: .utf8),
            let themes = try? JSONDecoder().decode([Game.Theme].self, from: data)
        else { return }
        self.themes = themes
    }

    private func autosaveThemes() {
        subscriptions.append($themes.sink { [userDefaults] themes in
            let data = (try? JSONEncoder().encode(themes)) ?? .init()
            let json = String(data: data, encoding: .utf8) ?? nil
            userDefaults.setValue(json, forKey: UserDefaults.Key.themes.rawValue)
        })
    }
}
