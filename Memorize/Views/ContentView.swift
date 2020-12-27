//
//  ContentView.swift
//  Memorize
//
//  Created by Martin Hettiger on 26.12.20.
//

import SwiftUI

struct ContentView: View {
    let game = EmojiMemoryGame.shared

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
        .font(.largeTitle)
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
