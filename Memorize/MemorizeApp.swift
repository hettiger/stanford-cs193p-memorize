//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Martin Hettiger on 26.12.20.
//

import SwiftUI
import Swinject

@main
struct MemorizeApp: App {
    let container = ContainerFactory.makeEmojiMemoryGameContainer()

    var body: some Scene {
        WindowGroup {
            RootView().withGlobalEnvironmentObjects(in: container)
        }
    }

    init() {
        resetDefaults()
    }

    private func resetDefaults() {
        #if DEBUG
            if CommandLine.arguments.contains(CommandLine.Argument.resetUserDefaults.rawValue) {
                container.resolve(UserDefaults.self)!.reset()
            }
        #endif
    }
}
