//
//  EmojiGameView.swift
//  Memorize
//
//  Created by Martin Hettiger on 26.12.20.
//

import SwiftUI

struct EmojiGameView: View {
    @State
    var theme: EmojiMemoryGame.Game.Theme

    @EnvironmentObject
    private var game: EmojiMemoryGame

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
        .foregroundColor(theme.color)
        .padding(padding)
        .navigationBarTitle(theme.name, displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Text("Score: \(game.score)").foregroundColor(.secondary)
            }
            ToolbarItemGroup(placement: .bottomBar) {
                EmojiGameViewBottomBar()
            }
        }
        .onReceive(game.$theme.dropFirst()) { newTheme in
            theme = newTheme
        }
        .onAppear {
            game.startFresh(theme: theme)
        }
    }

    // MARK: - Drawing Constants

    private let aspectRatio: CGFloat = 2 / 3
    private let padding: CGFloat = 10
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let container = MemorizeApp.container
        container.register(EmojiMemoryGame.Game.Theme.self, factory: { resolver in
            resolver.resolve([EmojiMemoryGame.Game.Theme].self)![3]
        })
        let game = container.resolve(EmojiMemoryGame.self)!
        game.choose(card: game.cards[3])

        return Group {
            NavigationView {
                EmojiGameView(theme: container.resolve(EmojiMemoryGame.Game.Theme.self)!)
                    .preferredColorScheme(.dark)
            }
            NavigationView {
                EmojiGameView(theme: container.resolve(EmojiMemoryGame.Game.Theme.self)!)
                    .preferredColorScheme(.light)
            }
        }
        .withGlobalEnvironmentObjects()
    }
}
