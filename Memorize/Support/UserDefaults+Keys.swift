//
//  UserDefaults+Keys.swift
//  Memorize
//
//  Created by Martin Hettiger on 02.01.21.
//

import Foundation

extension UserDefaults {
    enum Key: String, CaseIterable {
        case highscore, themes
    }

    func reset() {
        for key in Key.allCases {
            removeObject(forKey: key.rawValue)
        }
    }
}
