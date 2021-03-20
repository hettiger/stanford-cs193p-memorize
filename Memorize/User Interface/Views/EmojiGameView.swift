//
//  EmojiGameView.swift
//  Memorize
//
//  Created by Martin Hettiger on 26.12.20.
//

import SwiftUI
import Swinject

struct EmojiGameView: View {
    @EnvironmentObject
    var game: EmojiMemoryGame

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
        .navigationBarTitle(game.theme.name, displayMode: .inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Text("Score: \(game.score)").foregroundColor(.secondary)
            }
            /// - ToDo: On first navigation to this view it is appearing in a very weird way though this is probably a SwiftUI bug.
            ToolbarItemGroup(placement: .bottomBar) {
                Text("Highscore: \(game.highscore)").foregroundColor(.secondary)
                Spacer()
                Button("New Game") {
                    withAnimation(.easeInOut) {
                        game.startFresh()
                    }
                }
            }
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
                EmojiGameView()
                    .preferredColorScheme(.dark)
            }
            NavigationView {
                EmojiGameView()
                    .preferredColorScheme(.light)
            }
        }
        .withGlobalEnvironmentObjects()
        .environmentObject(game)
    }
}
