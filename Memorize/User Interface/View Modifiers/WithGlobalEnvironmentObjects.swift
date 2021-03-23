//
//  WithGlobalEnvironmentObjects.swift
//  Memorize
//
//  Created by Martin Hettiger on 13.03.21.
//

import SwiftUI

struct WithGlobalEnvironmentObjects: ViewModifier {
    func body(content: Content) -> some View {
        content
            .environmentObject(MemorizeApp.container.resolve(EmojiMemoryGame.self)!)
            .environmentObject(MemorizeApp.container.resolve(EmojiMemoryGameThemeStore.self)!)
    }
}

extension View {
    func withGlobalEnvironmentObjects() -> some View {
        modifier(WithGlobalEnvironmentObjects())
    }
}
