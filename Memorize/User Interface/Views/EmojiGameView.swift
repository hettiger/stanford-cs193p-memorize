//
//  EmojiGameView.swift
//  Memorize
//
//  Created by Martin Hettiger on 26.12.20.
//

import SwiftUI

struct EmojiGameView: View {
    @ObservedObject var game = EmojiMemoryGame.shared

    var body: some View {
        Grid(game.cards, desiredAspectRatio: aspectRatio) { card in
            EmojiCardView(card: card).onTapGesture {
                withAnimation(.linear) {
                    game.choose(card: card)
                }
            }
            .aspectRatio(aspectRatio, contentMode: .fit)
            .padding(padding)
            .accessibility(addTraits: .isButton)
            .accessibility(identifier: "Memory Game Card \(card.id)")
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
            EmojiGameView()
                .preferredColorScheme(.dark)
            EmojiGameView()
                .preferredColorScheme(.light)
        }
    }
}
