//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Martin Hettiger on 26.12.20.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
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
                UserDefaults.standard.reset()
            }
        #endif
    }
}
