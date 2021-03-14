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

    var body: some View {
        List {
            ForEach(store.themes) { theme in
                VStack(alignment: .leading, spacing: 8) {
                    HStack(alignment: .firstTextBaseline) {
                        Text(theme.name).foregroundColor(theme.color)
                            .font(.title2)
                        Text("(\(theme.cards.count) cards)")
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
    }
}

struct EmojiThemeChooser_Previews: PreviewProvider {
    static var previews: some View {
        let container = ContainerFactory.makeEmojiMemoryGameContainer()
        EmojiThemeChooser().withGlobalEnvironmentObjects(in: container)
    }
}
