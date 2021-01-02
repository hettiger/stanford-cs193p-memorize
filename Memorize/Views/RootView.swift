//
//  RootView.swift
//  Memorize
//
//  Created by Martin Hettiger on 02.01.21.
//

import SwiftUI

/// RootView
///
/// ViewInspector (Testing Library) has problems with `.navigationBarItems()` modifier.
/// Moving the `NavigationView` out of the way allows unit testing `ContentView`.
/// The `RootView` is covered with real UI tests.
struct RootView: View {
    @ObservedObject var game = EmojiMemoryGame.shared

    var body: some View {
        NavigationView {
            ContentView()
                .navigationBarItems(trailing: Button("New Game", action: game.restart))
                .navigationBarTitle(game.theme.name, displayMode: .inline)
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
