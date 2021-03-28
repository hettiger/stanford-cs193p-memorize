//
//  EmojiGameViewBottomBar.swift
//  Memorize
//
//  Created by Martin Hettiger on 28.03.21.
//

import SwiftUI

struct EmojiGameViewBottomBar: View {
    @EnvironmentObject
    private var game: EmojiMemoryGame

    var body: some View {
        Text("Highscore: \(game.highscore)").foregroundColor(.secondary)
        Spacer()
        Button("New Game") {
            withAnimation(.easeInOut) {
                game.startFresh()
            }
        }
    }
}
