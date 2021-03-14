//
//  WithGlobalEnvironmentObjects.swift
//  Memorize
//
//  Created by Martin Hettiger on 13.03.21.
//

import SwiftUI
import Swinject

struct WithGlobalEnvironmentObjects: ViewModifier {
    private var container: Container { MemorizeApp.container }

    func body(content: Content) -> some View {
        content
            .environmentObject(container.resolve(EmojiMemoryGameThemeStore.self)!)
    }
}

extension View {
    func withGlobalEnvironmentObjects() -> some View {
        return modifier(WithGlobalEnvironmentObjects())
    }
}
