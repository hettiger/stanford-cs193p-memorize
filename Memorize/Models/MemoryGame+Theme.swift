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
        let contents: Set<ContentType>
        let numberOfCards: Int?
        let color: Color

        var randomSource: GKRandomSource = .sharedRandom()

        private(set) lazy var cards: [Card] = {
            let contents = Array(self.contents)
            var cards = [Card]()
            for pairIndex in 0 ..< numberOfPairsOfCards {
                cards.append(Card(id: pairIndex * 2, content: contents[pairIndex]))
                cards.append(Card(id: pairIndex * 2 + 1, content: contents[pairIndex]))
            }
            cards.shuffle(using: randomSource)
            return cards
        }()

        private(set) lazy var numberOfPairsOfCards: Int = {
            if let numberOfCards = numberOfCards {
                return max(0, Int(numberOfCards / 2))
            }

            return .random(
                in: UInt32(min(2, contents.count)) ... UInt32(min(Int(UInt32.max), contents.count)),
                using: randomSource
            )
        }()
    }
}
