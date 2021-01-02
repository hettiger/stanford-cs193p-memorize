//
//  MemoryGame+Theme.swift
//  Memorize
//
//  Created by Martin Hettiger on 01.01.21.
//

import GameKit
import SwiftUI

extension MemoryGame {
    struct Theme: Hashable {
        let name: String
        let cards: [Card]
        let color: Color

        init<Contents: Sequence>(
            name: String,
            contents: Contents,
            numberOfCards: Int? = nil,
            color: Color = .clear,
            randomSource: GKRandomSource? = .sharedRandom()
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

            self.name = name
            self.cards = cards
            self.color = color
        }

        private static func numberOfPairsOfCards(
            numberOfCards: Int?,
            contents: Set<ContentType>,
            using randomSource: GKRandomSource?
        ) -> Int {
            if let numberOfCards = numberOfCards {
                return min(max(0, Int(numberOfCards / 2)), contents.count)
            }

            if let randomSource = randomSource {
                return .random(
                    in: UInt32(min(2, contents.count)) ...
                        UInt32(min(Int(UInt32.max), contents.count)),
                    using: randomSource
                )
            }

            return contents.count
        }

        private static func cards(
            for contents: Set<ContentType>,
            withNumberOfPairs numberOfPairs: Int,
            using randomSource: GKRandomSource? = nil
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
