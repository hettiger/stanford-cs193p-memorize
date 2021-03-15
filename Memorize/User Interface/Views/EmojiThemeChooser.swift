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
                NavigationLink(destination: EmojiGameView(theme: theme)) {
                    EmojiThemeChooserRow(theme: theme)
                }
            }
        }
    }
}

struct EmojiThemeChooser_Previews: PreviewProvider {
    static var previews: some View {
        EmojiThemeChooser().withGlobalEnvironmentObjects()
    }
}
