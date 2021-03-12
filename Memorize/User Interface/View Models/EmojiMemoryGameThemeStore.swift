//
//  EmojiMemoryGameThemeStore.swift
//  Memorize
//
//  Created by Martin Hettiger on 09.03.21.
//

import Foundation

class EmojiMemoryGameThemeStore {
    typealias Game = EmojiMemoryGame.Game

    var themes: [Game.Theme] {
        get {
            guard
                let json = userDefaults.string(forKey: UserDefaults.Key.themes.rawValue),
                let data = json.data(using: .utf8),
                let themes = try? JSONDecoder().decode([Game.Theme].self, from: data)
            else { return .init() }
            return themes
        }
        set {
            let data = (try? JSONEncoder().encode(newValue)) ?? .init()
            let json = String(data: data, encoding: .utf8) ?? nil
            userDefaults.setValue(json, forKey: UserDefaults.Key.themes.rawValue)
        }
    }

    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
}
