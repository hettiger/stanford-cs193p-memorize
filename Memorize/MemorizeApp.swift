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
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    private var container: Container { delegate.container }

    var body: some Scene {
        WindowGroup {
            RootView().environmentObject(container.resolve(EmojiMemoryGame.self)!)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    let container = ContainerFactory.makeEmojiMemoryGameContainer()
    
    func application(
        _: UIApplication,
        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        resetDefaults()
        return true
    }

    private func resetDefaults() {
        #if DEBUG
            if CommandLine.arguments.contains(CommandLine.Argument.resetUserDefaults.rawValue) {
                container.resolve(UserDefaults.self)!.reset()
            }
        #endif
    }
}
