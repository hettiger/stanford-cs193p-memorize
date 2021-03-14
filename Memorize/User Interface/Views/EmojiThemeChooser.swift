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

    var body: some View {
        List {
            ForEach(store.themes) { theme in
                NavigationLink(destination: LazyView(destination(for: theme))) {
                    EmojiThemeChooserRow(theme: theme)
                }
            }
        }
    }

    private func destination(for theme: Game.Theme) -> some View {
        let container = MemorizeApp.container
        let game = container.resolve(EmojiMemoryGame.self, argument: theme)!
        return EmojiGameView().environmentObject(game)
    }
}

struct EmojiThemeChooser_Previews: PreviewProvider {
    static var previews: some View {
        EmojiThemeChooser().withGlobalEnvironmentObjects()
    }
}
