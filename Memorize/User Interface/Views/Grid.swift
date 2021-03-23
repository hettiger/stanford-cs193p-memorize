//
//  Grid.swift
//  Memorize
//
//  Created by Martin Hettiger on 30.12.20.
//

import SwiftUI

struct Grid<Item: Identifiable, ItemView: View>: View where Item: Hashable {
    var items: [Item]
    var desiredAspectRatio: Double
    var viewForItem: (Item) -> ItemView

    init(
        _ items: [Item],
        desiredAspectRatio: CGFloat = 1,
        viewForItem: @escaping (Item) -> ItemView
    ) {
        self.items = items
        self.desiredAspectRatio = Double(desiredAspectRatio)
        self.viewForItem = viewForItem
    }

    var body: some View {
        GeometryReader { geometry in
            let layout = GridLayout(
                itemCount: items.count,
                nearAspectRatio: desiredAspectRatio,
                in: geometry.size
            )
            let (width, height) = (layout.itemSize.width, layout.itemSize.height)
            ForEach(items) { item in
                let position = layout.location(ofItemAt: items.firstIndex(of: item)!)
                viewForItem(item).frame(width: width, height: height).position(position)
            }
        }
    }
}

struct Grid_Previews: PreviewProvider {
    static var previews: some View {
        let game = MemorizeApp.container.resolve(EmojiMemoryGame.self)!

        Grid(game.cards) { card in
            EmojiCardView(card: card)
                .aspectRatio(CGFloat(2) / 3, contentMode: .fit)
                .padding()
        }
        .withGlobalEnvironmentObjects()
    }
}
