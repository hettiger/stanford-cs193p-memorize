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
            }
            .accessibilityIdentifier("Memory Game Card \(card.id)")
            .padding(ContentView.padding)
        }
        .foregroundColor(game.theme.color)
        .padding(ContentView.padding)
    }

    // MARK: - Drawing Constants

    static let padding: CGFloat = 10
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
