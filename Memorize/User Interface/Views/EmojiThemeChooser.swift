//
//  EmojiThemeChooser.swift
//  Memorize
//
//  Created by Martin Hettiger on 13.03.21.
//

import SwiftUI

struct EmojiThemeChooser: View {
    @EnvironmentObject
    private var store: EmojiMemoryGameThemeStore

    @EnvironmentObject
    private var game: EmojiMemoryGame

    @State
    private var isShowingGameView = false

    @State
    private var isShowingThemeEditor = false

    @State
    private var editMode: EditMode

    init(editMode: EditMode = .inactive) {
        _editMode = State(initialValue: editMode)
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(store.themes) { theme in
                    NavigationLink(destination: EmojiGameView(), isActive: $isShowingGameView) {
                        EmojiThemeChooserRow(
                            theme: theme,
                            editMode: $editMode
                        )
                    }
                    .sheet(isPresented: $isShowingThemeEditor) {
                        EmojiThemeEditor()
                    }
                    .onTapGesture {
                        if editMode.isEditing {
                            isShowingThemeEditor = true
                            return
                        }

                        game.theme = theme
                        isShowingGameView = true
                    }
                }
                .onDelete(perform: delete(_:))
            }
            .navigationBarTitle("Memorize")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItemGroup(placement: .bottomBar) {
                    EmojiThemeChooserBottomBar()
                }
            })
            .environment(\.editMode, $editMode)
        }
    }

    private func delete(_ indexSet: IndexSet) {
        store.themes.remove(atOffsets: indexSet)
    }
}

struct EmojiThemeChooser_Previews: PreviewProvider {
    static var previews: some View {
        let container = MemorizeApp.container
        let themes = container.resolve([EmojiMemoryGame.Game.Theme].self)!
        let store = container.resolve(EmojiMemoryGameThemeStore.self)!
        store.themes = themes

        return Group {
            EmojiThemeChooser()
                .withGlobalEnvironmentObjects()
            EmojiThemeChooser(editMode: .active)
                .withGlobalEnvironmentObjects()
        }
    }
}
