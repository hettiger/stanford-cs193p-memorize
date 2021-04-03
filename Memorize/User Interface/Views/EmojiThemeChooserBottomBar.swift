//
//  EmojiThemeChooserBottomBar.swift
//  Memorize
//
//  Created by Martin Hettiger on 28.03.21.
//

import SwiftUI

struct EmojiThemeChooserBottomBar: View {
    @EnvironmentObject
    private var store: EmojiMemoryGameThemeStore

    var body: some View {
        Spacer()
        Button(action: add) {
            Label("Add Theme", systemImage: "plus")
        }
    }

    private func add() {
        withAnimation {
            store.themes.append(.init(name: "Untitled", contents: "🌱☀️", color: .green))
        }
    }
}
