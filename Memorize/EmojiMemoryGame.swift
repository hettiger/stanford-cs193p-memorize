//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Martin Hettiger on 27.12.20.
//

import Foundation

class EmojiMemoryGame {
    static var shared = EmojiMemoryGame()
    
    private lazy var game: MemoryGame<String> = {
        let emojis = "🐶🐱🐭🐰"
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) { pairIndex in
            emojis[pairIndex]
        }
    }()
    
    // MARK: - Model Accessors
    
    var cards: [MemoryGame<String>.Card] {
        game.cards
    }
    
    // MARK: - Intents
    
    func choose(card: MemoryGame<String>.Card) {
        game.choose(card: card)
    }
}
