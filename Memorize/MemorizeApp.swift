//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Martin Hettiger on 26.12.20.
//

import SwiftUI

@main
struct MemorizeApp: App {
    static let container = ContainerFactory.makeEmojiMemoryGameContainer()

    var body: some Scene {
        WindowGroup {
            RootView().withGlobalEnvironmentObjects()
        }
    }

    init() {
        resetDefaults()
    }

    private func resetDefaults() {
        #if DEBUG
            if CommandLine.arguments.contains(CommandLine.Argument.resetUserDefaults.rawValue) {
                MemorizeApp.container.resolve(UserDefaults.self)!.reset()
            }
        #endif
    }
}
