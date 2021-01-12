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
        Grid(game.cards, desiredAspectRatio: aspectRatio) { card in
            CardView(card: card).onTapGesture {
                game.choose(card: card)
            }
            .accessibilityIdentifier("Memory Game Card \(card.id)")
            .aspectRatio(aspectRatio, contentMode: .fit)
            .padding(padding)
        }
        .foregroundColor(game.theme.color)
        .padding(padding)
    }

    // MARK: - Drawing Constants

    private let aspectRatio: CGFloat = 2 / 3
    private let padding: CGFloat = 10
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame.shared
        game.theme = EmojiMemoryGame.themes[3]
        game.choose(card: game.cards[3])

        return Group {
            ContentView()
                .preferredColorScheme(.dark)
            ContentView()
                .preferredColorScheme(.light)
        }
    }
}
