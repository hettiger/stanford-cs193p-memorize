//
//  ContentView.swift
//  Memorize
//
//  Created by Martin Hettiger on 26.12.20.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var game = EmojiMemoryGame.shared

    var body: some View {
        Grid(game.cards, desiredAspectRatio: CardView.aspectRatio) { card in
            CardView(card: card).onTapGesture {
                game.choose(card: card)
            }.padding()
        }
        .foregroundColor(.orange)
        .padding()
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
