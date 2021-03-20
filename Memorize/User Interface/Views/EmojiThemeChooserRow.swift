//
//  EmojiThemeChooserRow.swift
//  Memorize
//
//  Created by Martin Hettiger on 14.03.21.
//

import SwiftUI

struct EmojiThemeChooserRow: View {
    var theme: EmojiMemoryGame.Game.Theme

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .firstTextBaseline) {
                Text(theme.name).foregroundColor(theme.color)
                    .font(.title2)
                Text("(\(theme.contents.count * 2) cards)")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            Text("All of \(theme.contents.map { String($0) }.joined())")
                .font(.footnote)
                .foregroundColor(.secondary)
                .lineLimit(1)
        }
    }
}

struct EmojiThemeChooserRow_Previews: PreviewProvider {
    static var previews: some View {
        let container = ContainerFactory.makeEmojiMemoryGameContainer()
        List {
            EmojiThemeChooserRow(theme: container.resolve([EmojiMemoryGame.Game.Theme].self)![0])
        }
    }
}
