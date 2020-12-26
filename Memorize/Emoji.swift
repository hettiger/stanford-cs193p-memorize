//
//  Emoji.swift
//  Memorize
//
//  Created by Martin Hettiger on 26.12.20.
//

import Foundation

struct Emoji {
    static let all = [
        "🐶🐱🐭🐰",
        "🍏🍊🍉🍓",
        "⚽️🏀🏈🎾",
        "🚗🚌🚓🚜",
        "⌚️💻📱🖨",
    ]

    static var sections: Int {
        all.count
    }

    static func items(inSection section: Int) -> Int {
        all[section].count
    }

    static func at(_ indexPath: IndexPath) -> String {
        let emojis = all[indexPath.section]
        let index = emojis.index(emojis.startIndex, offsetBy: indexPath.item)
        return String(emojis[index])
    }
}
