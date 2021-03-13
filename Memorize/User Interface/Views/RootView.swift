//
//  RootView.swift
//  Memorize
//
//  Created by Martin Hettiger on 02.01.21.
//

import SwiftUI
import Swinject

struct RootView: View {
    @EnvironmentObject var game: EmojiMemoryGame

    var body: some View {
        NavigationView {
            EmojiGameView()
                .navigationBarItems(trailing: Text("Score: \(game.score)"))
                .navigationBarTitle(game.theme.name, displayMode: .inline)
                .toolbar {
                    ToolbarItemGroup(placement: .bottomBar) {
                        Text("Highscore: \(game.highscore)")
                        Spacer()
                        Button("New Game") {
                            withAnimation(.easeInOut) {
                                game.startFresh()
                            }
                        }
                    }
                }
                .foregroundColor(.secondary)
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        let container = ContainerFactory.makeEmojiMemoryGameContainer()

        Group {
            RootView()
        }
        .withGlobalEnvironmentObjects(in: container)
    }
}
