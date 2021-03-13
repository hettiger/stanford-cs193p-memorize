//
//  WithGlobalEnvironmentObjects.swift
//  Memorize
//
//  Created by Martin Hettiger on 13.03.21.
//

import SwiftUI
import Swinject

struct WithGlobalEnvironmentObjects: ViewModifier {
    let container: Container

    func body(content: Content) -> some View {
        content
            .environmentObject(container.resolve(EmojiMemoryGameThemeStore.self)!)
            .environmentObject(container.resolve(EmojiMemoryGame.self)!)
    }
}

extension View {
    func withGlobalEnvironmentObjects(in container: Container) -> some View {
        return modifier(WithGlobalEnvironmentObjects(container: container))
    }
}
