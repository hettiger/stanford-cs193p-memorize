//
//  ContentView.swift
//  Memorize
//
//  Created by Martin Hettiger on 26.12.20.
//

import SwiftUI

struct ContentView: View {
    var game = EmojiMemoryGame.shared

    var body: some View {
        HStack {
            ForEach(game.cards) { card in
                CardView(
                    isFaceUp: card.isFaceUp,
                    emoji: card.content
                ).onTapGesture {
                    game.choose(card: card)
                }
            }
        }
        .padding()
        .foregroundColor(.orange)
        .font(numberOfPairsOfCards < 5 ? .largeTitle : .body)
    }
    
    var numberOfPairsOfCards: Int {
        get { game.cards.count / 2 }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .preferredColorScheme(.dark)
            ContentView()
                .preferredColorScheme(.light)
        }
    }
}
