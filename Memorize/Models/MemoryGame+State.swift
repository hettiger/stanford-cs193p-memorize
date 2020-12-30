//
//  MemoryGame+State.swift
//  MemorizeTests
//
//  Created by Martin Hettiger on 30.12.20.
//

import Foundation

extension MemoryGame {
    enum State: Equatable {
        case noCardFaceUp
        case oneCardFaceUp(Card.ID)
        case twoCardsFaceUp(Card.ID, Card.ID)

        func showsMatch(in cards: [Card]) -> Bool {
            switch self {
            case let .twoCardsFaceUp(idA, idB):
                let cardA = cards.first(with: idA)!
                let cardB = cards.first(with: idB)!
                return cardA.content == cardB.content
            default:
                return false
            }
        }
    }
}
