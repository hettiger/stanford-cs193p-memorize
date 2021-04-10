//
//  EmojiThemeChooserRow.swift
//  Memorize
//
//  Created by Martin Hettiger on 14.03.21.
//

import SwiftUI

struct EmojiThemeChooserRow: View {
    var theme: EmojiMemoryGame.Game.Theme

    @Binding
    var editMode: EditMode

    @State
    private var isShowingThemeEditor = false

    var body: some View {
        HStack(alignment: .center, spacing: 0, content: {
            if editMode == EditMode.active {
                EditableListRowIndicator(color: theme.color)
                    .onTapGesture {
                        isShowingThemeEditor = true
                    }
                    .sheet(isPresented: $isShowingThemeEditor) {
                        EmojiThemeEditor(theme: theme, isPresented: $isShowingThemeEditor)
                    }
            }
            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .firstTextBaseline) {
                    Text(theme.name)
                        // `foregroundColor` + `colorMultiply` is used in combination to get
                        // animated text color changes basically for free
                        .foregroundColor(.white)
                        .colorMultiply(editMode == .active ? .black : theme.color)
                        .font(.title2)
                    Text("(\(theme.contents.count * 2) cards)")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                Text("All of \(theme.contents.map { String($0) }.joined())")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                    .animation(nil)
            }
        })
    }
}

struct EmojiThemeChooserRow_Previews: PreviewProvider {
    static var previews: some View {
        let container = ContainerFactory.makeEmojiMemoryGameContainer()
        let theme = container.resolve([EmojiMemoryGame.Game.Theme].self)![0]

        List {
            EmojiThemeChooserRow(theme: theme, editMode: .constant(.inactive))
            EmojiThemeChooserRow(theme: theme, editMode: .constant(.active))
        }
    }
}
