//
//  EmojiThemeChooser.swift
//  Memorize
//
//  Created by Martin Hettiger on 13.03.21.
//

import SwiftUI

struct EmojiThemeChooser: View {
    private typealias Game = EmojiMemoryGame.Game

    @EnvironmentObject
    var store: EmojiMemoryGameThemeStore

    @EnvironmentObject
    var game: EmojiMemoryGame

    @State
    private var isShowingGameView = false

    var body: some View {
        List {
            ForEach(store.themes) { theme in
                Button {
                    game.theme = theme
                    isShowingGameView = true
                } label: {
                    EmojiThemeChooserRow(theme: theme)
                }
            }
        }
        .background(NavigationLink(destination: EmojiGameView(), isActive: $isShowingGameView) {
            EmptyView()
        })
    }
}

struct EmojiThemeChooser_Previews: PreviewProvider {
    static var previews: some View {
        EmojiThemeChooser().withGlobalEnvironmentObjects()
    }
}
