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
                    .onTapGesture {
                        if editMode.isEditing {
                            // TODO: Show theme editor
                            print("show theme editor")
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
                ToolbarItemGroup(placement: ToolbarItemPlacement.navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItemGroup(placement: .bottomBar) {
                    Spacer()
                    Button(action: add) {
                        Label("Add Theme", systemImage: "plus")
                    }
                }
            })
            .environment(\.editMode, $editMode)
        }
    }

    private func add() {
        withAnimation {
            store.themes.append(.init(name: "Untitled", contents: "🌱", color: .green))
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
