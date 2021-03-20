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
    private let themesSeed: [Game.Theme]

    @Published
    var themes = [Game.Theme]()

    private var subscriptions = [AnyCancellable]()

    private var didSeedThemes: Bool {
        get { userDefaults.bool(forKey: UserDefaults.Key.didSeedThemes.rawValue) }
        set { userDefaults.setValue(newValue, forKey: UserDefaults.Key.didSeedThemes.rawValue) }
    }

    init(userDefaults: UserDefaults, themesSeed: [Game.Theme]) {
        self.userDefaults = userDefaults
        self.themesSeed = themesSeed

        seedThemes()
        fetchThemes()
        autosaveThemes()
    }

    private func seedThemes() {
        guard !didSeedThemes else { return }
        themes = themesSeed
        didSeedThemes = true
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
