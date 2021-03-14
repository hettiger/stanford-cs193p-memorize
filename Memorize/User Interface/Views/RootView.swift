//
//  RootView.swift
//  Memorize
//
//  Created by Martin Hettiger on 02.01.21.
//

import SwiftUI
import Swinject

struct RootView: View {
    @EnvironmentObject var game: EmojiMemoryGame

    var body: some View {
        NavigationView {
            EmojiThemeChooser()
                .navigationBarTitle("Memorize")
                .foregroundColor(.secondary)
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RootView()
        }
        .withGlobalEnvironmentObjects()
    }
}
