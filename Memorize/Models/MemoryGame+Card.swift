//
//  MemoryGame+Card.swift
//  Memorize
//
//  Created by Martin Hettiger on 27.12.20.
//

import Foundation

extension MemoryGame {
    struct Card: Identifiable {
        let id: Int
        let content: ContentType

        private(set) var isFaceUp = false

        mutating func choose() {
            isFaceUp.toggle()
            print("chose card: \(self)")
        }
    }
}
