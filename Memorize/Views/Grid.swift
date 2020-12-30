//
//  Grid.swift
//  Memorize
//
//  Created by Martin Hettiger on 30.12.20.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    var items: [Item]
    var viewForItem: (Item) -> ItemView

    init(_ items: [Item], viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }

    var body: some View {
        GeometryReader { geometry in
            let layout = GridLayout(itemCount: items.count, in: geometry.size)
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
        Grid(EmojiMemoryGame.shared.cards) { card in
            CardView(card: card).padding()
        }
    }
}
