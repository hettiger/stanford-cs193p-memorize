//
//  EmojiThemeChooser.swift
//  Memorize
//
//  Created by Martin Hettiger on 13.03.21.
//

import SwiftUI

struct EmojiThemeChooser: View {
    @EnvironmentObject
    var store: EmojiMemoryGameThemeStore

    @EnvironmentObject
    var game: EmojiMemoryGame

    @State
    private var isShowingGameView: Bool = false

    var body: some View {
        List {
            ForEach(store.themes) { theme in
                NavigationLink(destination: EmojiGameView(), isActive: $isShowingGameView) {
                    EmojiThemeChooserRow(theme: theme)
                }
                .onTapGesture {
                    game.theme = theme
                    isShowingGameView = true
                }
            }
        }
    }
}

struct EmojiThemeChooser_Previews: PreviewProvider {
    static var previews: some View {
        let container = MemorizeApp.container
        let themes = container.resolve([EmojiMemoryGame.Game.Theme].self)!
        let store = container.resolve(EmojiMemoryGameThemeStore.self)!
        store.themes = themes

        return EmojiThemeChooser().withGlobalEnvironmentObjects()
    }
}
