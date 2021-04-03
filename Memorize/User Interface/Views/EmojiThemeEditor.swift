//
//  EmojiThemeEditor.swift
//  Memorize
//
//  Created by Martin Hettiger on 30.03.21.
//

import SwiftUI

/// Emoji Theme Editor
///
/// - ToDo: Finalize theme editor implementation
struct EmojiThemeEditor: View {
    var theme: EmojiMemoryGame.Game.Theme

    @State
    private var themeName = ""

    @State
    private var themeColor: Color = .clear

    /// The number of pairs of cards
    ///
    /// - ToDo: Add support for this on the model level
    @State
    private var themeNumberOfPairsOfCards = 2

    @State
    private var themeContents = [Character]()

    @State
    private var emojisToAdd = ""

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $themeName)
                ColorPicker("Color", selection: $themeColor)
            }
            Section(header: Text("Add Emoji")) {
                TextField("Emoji", text: $emojisToAdd) { began in
                    if !began {
                        var newContents = Set(themeContents)
                        emojisToAdd.forEach { newContents.insert($0) }
                        emojisToAdd = ""
                        themeContents = newContents.sorted()
                    }
                }
            }
            Section(header: Text("Emojis")) {
                Grid(themeContents) { emoji in
                    Text(String(emoji))
                        .font(.largeTitle)
                        .padding(2)
                        .fixedSize()
                }
                .frame(height: emojiGridHeight)
            }
            Section(header: Text("Card Count")) {
                Stepper(value: $themeNumberOfPairsOfCards, in: 2 ... max(2, themeContents.count)) {
                    Text("\(themeNumberOfPairsOfCards) Pairs")
                }
            }
        }
        .onAppear {
            themeName = theme.name
            themeColor = theme.color
            themeNumberOfPairsOfCards = theme.contents.count
            themeContents = theme.contents.sorted()
        }
    }

    // MARK: - Drawing Constants

    var emojiGridHeight: CGFloat {
        CGFloat((themeContents.count - 1) / 6) * 70 + 70
    }
}

extension Character: Identifiable {
    public var id: Character { self }
}

struct EmojiThemeEditor_Previews: PreviewProvider {
    static var previews: some View {
        EmojiThemeEditor(
            theme: .init(name: "Theme Name", contents: "🐶🐭🐰🦊🐻", color: .orange)
        )
    }
}