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
    typealias Theme = EmojiMemoryGame.Game.Theme

    class ErrorBag: ObservableObject {
        enum Key {
            case contents
        }

        @Published
        private(set) var errors = [Key: String?]()

        subscript(key: Key) -> String? {
            get { errors[key] ?? nil }
            set { errors[key] = newValue }
        }

        func clear() {
            guard !errors.isEmpty else { return }
            errors = [:]
        }
    }

    var theme: Theme

    @EnvironmentObject
    private var store: EmojiMemoryGameThemeStore

    @Binding
    var isPresented: Bool

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

    @ObservedObject
    private var errorBag = ErrorBag()

    var body: some View {
        NavigationView {
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
                Section(
                    header: HStack {
                        Text("Emojis").textCase(.uppercase)
                        Spacer()
                        Text("tap to exclude")
                    },
                    footer: Group {
                        if let error = errorBag[.contents] {
                            Text(error).foregroundColor(.red)
                        }
                    }
                ) {
                    Grid(themeContents) { emoji in
                        Text(String(emoji))
                            .font(.largeTitle)
                            .padding(2)
                            .fixedSize()
                            .onTapGesture {
                                guard themeContents.count > 2 else {
                                    withAnimation {
                                        errorBag[.contents] =
                                            "A theme must consist of two or more emojis."
                                    }
                                    return
                                }
                                guard let index = themeContents.firstIndex(of: emoji)
                                else { return }
                                themeContents.remove(at: index)
                            }
                    }
                    .frame(height: emojiGridHeight)
                }
                .textCase(.none)
                Section(header: Text("Card Count")) {
                    Stepper(
                        value: $themeNumberOfPairsOfCards,
                        in: 2 ... max(2, themeContents.count)
                    ) {
                        Text("\(themeNumberOfPairsOfCards) Pairs")
                    }
                }
            }
            .navigationTitle("Theme Editor")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: cancel, label: {
                        Text("Cancel")
                    })
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: save, label: {
                        Text("Save")
                    })
                }
            })
            .onAppear {
                themeName = theme.name
                themeColor = theme.color
                themeNumberOfPairsOfCards = theme.contents.count
                themeContents = theme.contents.sorted()
            }
            .onReceive(errorBag.$errors.debounce(for: errorTTL, scheduler: scheduler)) { _ in
                withAnimation {
                    errorBag.clear()
                }
            }
        }
    }

    private func cancel() {
        isPresented = false
    }

    private func save() {
        let newTheme = Theme(name: themeName, contents: themeContents, color: themeColor)
        let index = store.themes.firstIndex { $0.id == theme.id }!
        store.themes[index] = newTheme

        isPresented = false
    }

    // MARK: - Drawing Constants

    let scheduler = RunLoop.main
    let errorTTL: RunLoop.SchedulerTimeType.Stride = 8

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
            theme: .init(name: "Theme Name", contents: "🐶🐭🐰🦊🐻", color: .orange),
            isPresented: .constant(true)
        )
    }
}
