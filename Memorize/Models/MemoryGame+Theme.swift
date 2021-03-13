//
//  MemoryGame+Theme.swift
//  Memorize
//
//  Created by Martin Hettiger on 01.01.21.
//

import GameKit
import SwiftUI

extension MemoryGame {
    struct Theme: Hashable, Codable, Identifiable {
        let name: String
        let cards: [Card]
        let color: Color
        
        private(set) var id = UUID()

        var json: String? {
            if let data = try? JSONEncoder().encode(self) {
                return String(data: data, encoding: .utf8)
            }
            return nil
        }

        init<Contents: Sequence>(
            name: String,
            contents: Contents,
            numberOfPairsOfCards: Int,
            color: Color = .clear,
            randomSource: RandomSource? = nil
        ) where Contents.Element == ContentType {
            let contents = Set(contents)

            let cards = Theme.cards(
                for: contents,
                withNumberOfPairs: max(0, min(contents.count, numberOfPairsOfCards)),
                using: randomSource
            )

            self.name = name
            self.cards = cards
            self.color = color
        }

        private static func cards(
            for contents: Set<ContentType>,
            withNumberOfPairs numberOfPairs: Int,
            using randomSource: RandomSource? = nil
        ) -> [Card] {
            let contents = Array(contents)
            var cards = [Card]()
            for pairIndex in 0 ..< numberOfPairs {
                cards.append(Card(id: pairIndex * 2, content: contents[pairIndex]))
                cards.append(Card(id: pairIndex * 2 + 1, content: contents[pairIndex]))
            }
            if let randomSource = randomSource {
                cards.shuffle(using: randomSource)
            }
            return cards
        }
    }
}
