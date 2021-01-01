//
//  MemoryGame+Theme.swift
//  Memorize
//
//  Created by Martin Hettiger on 01.01.21.
//

import GameKit
import SwiftUI

extension MemoryGame {
    struct Theme {
        let name: String
        let color: Color
        let cards: [Card]

        init<Contents: Sequence>(
            name: String,
            contents: Contents,
            numberOfCards: Int? = nil,
            color: Color = .clear,
            randomSource: GKRandomSource = .sharedRandom()
        ) where Contents.Element == ContentType {
            let contents = Set(contents)

            let numberOfPairsOfCards = Theme.numberOfPairsOfCards(
                numberOfCards: numberOfCards,
                contents: contents,
                using: randomSource
            )

            let cards = Theme.cards(
                for: contents,
                withNumberOfPairs: numberOfPairsOfCards,
                using: randomSource
            )

            self.init(name: name, color: color, cards: cards)
        }

        init(name: String, color: Color = .clear, cards: [Card]) {
            self.name = name
            self.color = color
            self.cards = cards
        }

        private static func numberOfPairsOfCards(
            numberOfCards: Int?,
            contents: Set<ContentType>,
            using randomSource: GKRandomSource
        ) -> Int {
            if let numberOfCards = numberOfCards {
                return min(max(0, Int(numberOfCards / 2)), contents.count)
            }

            return .random(
                in: UInt32(min(2, contents.count)) ... UInt32(min(Int(UInt32.max), contents.count)),
                using: randomSource
            )
        }

        private static func cards(
            for contents: Set<ContentType>,
            withNumberOfPairs numberOfPairs: Int,
            using randomSource: GKRandomSource
        ) -> [Card] {
            let contents = Array(contents)
            var cards = [Card]()
            for pairIndex in 0 ..< numberOfPairs {
                cards.append(Card(id: pairIndex * 2, content: contents[pairIndex]))
                cards.append(Card(id: pairIndex * 2 + 1, content: contents[pairIndex]))
            }
            cards.shuffle(using: randomSource)
            return cards
        }
    }
}
