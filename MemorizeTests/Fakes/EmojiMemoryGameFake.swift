//
//  EmojiMemoryGameFake.swift
//  MemorizeTests
//
//  Created by Martin Hettiger on 28.12.20.
//

import Foundation
@testable import Memorize

class EmojiMemoryGameFake: EmojiMemoryGame {
    override var cards: [MemoryGame<String>.Card] {
        get { _cards }
        set { _cards = newValue }
    }

    private var _cards = [MemoryGame<String>.Card]()
}
