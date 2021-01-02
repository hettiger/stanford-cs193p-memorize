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

        var isFaceUp = false {
            willSet {
                if isFaceUp {
                    hasBeenFaceUp = true
                }
            }
        }
        
        private(set) var hasBeenFaceUp = false
        var isMatched = false
    }
}
