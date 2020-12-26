//
//  ContentView.swift
//  Memorize
//
//  Created by Martin Hettiger on 26.12.20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            ForEach(0 ..< Emoji.sections) { section in
                HStack {
                    ForEach(0 ..< Emoji.items(inSection: section)) { item in
                        CardView(
                            isFaceUp: item.isEven,
                            emoji: Emoji.at(IndexPath(item: item, section: section))
                        )
                    }
                }
            }
        }
        .padding()
        .foregroundColor(.orange)
        .font(.largeTitle)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .preferredColorScheme(.dark)
            ContentView()
                .preferredColorScheme(.light)
        }
    }
}
